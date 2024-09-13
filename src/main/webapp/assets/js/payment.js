$(document).ready(function () {
    let isSuccess = false;
    let payInterval;
    let timeOut;
    let countdownInterval;
    let modal = document.getElementById('qrModal');
    let countdownElement = document.getElementById('countdown');
    let initialCountdownTime = 300; // Thời gian đếm ngược (giây)
    let countdownTime = initialCountdownTime;
    const MY_BANK = {
        BANK_ID: 'MBBank',
        BANK_NO: '0000001262665'
    };

    // Xử lý khi người dùng chọn phương thức thanh toán qua QR
    document.getElementById('qr').addEventListener('change', function () {
        var img = document.getElementById('QRCODE-Img');
        var paidPrice = document.getElementById('total').textContent;
        let formattedNumber = paidPrice.replace(/[, ₫]/g, '');
        console.log(formattedNumber);

        // Sinh mã 4 số ngẫu nhiên
        let randomCode = generateRandomCode();
        var paidContent = `${document.getElementById('nameReceive').textContent} chuyen khoan ${randomCode}`;
        var content = convertString(paidContent);
        console.log(content);

        // Hiển thị modal
        modal.style.display = 'flex';

        // Đặt đường dẫn QR code
        var qrUrl = `https://api.vieqr.com/vietqr/${MY_BANK.BANK_ID}/${MY_BANK.BANK_NO}/${formattedNumber}/full.jpg?FullName=CAO%20THANH%20TAN&NDck=${content}`;
        img.src = qrUrl;

        // Đặt lại thời gian đếm ngược
        countdownTime = initialCountdownTime;
        updateCountdownDisplay(countdownTime);

        // Đặt interval để kiểm tra thanh toán
        timeOut = setTimeout(() => {
            payInterval = setInterval(() => {
                checkPay(formattedNumber, paidContent);
            }, 1000);
        }, 2000);

        // Ẩn scrollbar trên body
        document.body.style.overflow = 'hidden';

        // Thiết lập thời gian đếm ngược
        countdownInterval = setInterval(() => {
            if (countdownTime > 0) {
                countdownTime--;
                updateCountdownDisplay(countdownTime);
            } else {
                clearInterval(countdownInterval);
                closeModal(); // Đóng modal khi hết thời gian đếm ngược
            }
        }, 1000);
    });

    // Sự kiện click ra ngoài modal để đóng modal
    window.addEventListener('click', function (event) {
        if (event.target === modal) {
            closeModal();
        }
    });

    function closeModal() {
        modal.style.display = 'none';
        document.body.style.overflow = ''; // Khôi phục lại scrollbar

        // Dừng interval và timeout
        clearInterval(payInterval);
        clearTimeout(timeOut);
        clearInterval(countdownInterval);

        // Đặt lại biến isSuccess về false khi đóng modal
        isSuccess = false;
    }

    async function checkPay(total, content) {
        if (isSuccess) {
            return;
        } else {
            try {
                const response = await fetch('https://script.google.com/macros/s/AKfycbxxkHpsxmSHWtQryJpvk1zyz8Vs8aq557OzYsFPDPxSus9UEXTQUjrMxERS44Az1jqw/exec');
                const data = await response.json();
                const lastPay = data.data[data.data.length - 1];
                const lastTotal = lastPay['Giá trị'];
                console.log(lastTotal);
                const lastContent = lastPay['Mô tả'];
                console.log(lastContent);
                if (lastTotal >= total && lastContent.includes(content.trim().toUpperCase())) {
                    isSuccess = true;
                    closeModal(); // Đóng modal khi thanh toán thành công

                    fetch('/PaymentByQRCodeControll', {
                        method: 'POST',
                        // body: formData
                    })
                        .then(response => response.text())
                        .then(data => {
                            console.log('PaymentByQRCodeControll response:', data);
                            // Redirect to success page if necessary
                            window.location.href = '/CheckOutSuccessControll';
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });

                } else {
                    console.log('Thanh toán thất bại');
                }
            } catch {
                console.error('ERROR');
            }
        }
    }

    function generateRandomCode() {
        return Math.floor(1000 + Math.random() * 9000); // Sinh số ngẫu nhiên từ 1000 đến 9999
    }

    function removeDiacritics(str) {
        const diacriticsMap = {
            'a': 'áàảãạăắằẳẵặâấầẩẫậ',
            'A': 'ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ',
            'd': 'đ',
            'D': 'Đ',
            'e': 'éèẻẽẹêếềểễệ',
            'E': 'ÉÈẺẼẸÊẾỀỂỄỆ',
            'i': 'íìỉĩị',
            'I': 'ÍÌỈĨỊ',
            'o': 'óòỏõọôốồổỗộơớờởỡợ',
            'O': 'ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ',
            'u': 'úùủũụưứừửữự',
            'U': 'ÚÙỦŨỤƯỨỪỬỮỰ',
            'y': 'ýỳỷỹỵ',
            'Y': 'ÝỲỶỸỴ'
        };

        // Replace diacritics with corresponding characters
        for (const key in diacriticsMap) {
            const characters = diacriticsMap[key];
            for (let i = 0; i < characters.length; i++) {
                str = str.replace(new RegExp(characters[i], 'g'), key);
            }
        }

        return str;
    }

    function convertString(str) {
        // Remove diacritics
        str = removeDiacritics(str);
        // Replace spaces with %20
        str = str.replace(/ /g, '%20');
        return str;
    }

    function updateCountdownDisplay(time) {
        let minutes = Math.floor(time / 60);
        let seconds = time % 60;
        countdownElement.textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
    }
});
