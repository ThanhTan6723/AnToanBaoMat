<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Payment</title>
    <!-- Css Styles -->
    <jsp:include page="./link/link.jsp"></jsp:include>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            padding-bottom: 5vh;
            margin-left: 20px;
        }

        td {
            padding-top: 10px;
            padding-bottom: 20px;
        }

        .checkout__input {
            margin-top: 15px;
            margin-bottom: 20px;
            margin-right: 20px;
            /*display: flex;*/
            /*flex-direction: row;*/
            position: relative;
        }

        .xBNaac {
            background-image: repeating-linear-gradient(45deg, #6fa6d6, #6fa6d6 33px, transparent 0, transparent 41px, #f18d9b 0, #f18d9b 74px, transparent 0, transparent 82px);
            background-position-x: -30px;
            background-size: 116px 3px;
            height: 3px;
            width: 100%;
            margin-bottom: 25px;
        }

        .radio-item {
            margin-left: 10px;
            margin-top: 10px;

        }

        .radio-group {
            display: flex;
            flex-direction: column;
            gap: 10px; /* Khoảng cách giữa các nút radio */
            margin-top: 10px; /* Khoảng cách phía trên */
        }

        .radio-item {
            align-items: center;
            position: relative;
            padding-left: 5px;
            cursor: pointer;
            user-select: none;
        }

        .radio-item label {
            margin-left: 10px;
            font-size: 16px;
            color: #333;
        }

        .radio-item input:checked ~ label {
            color: #7fad39;
            font-weight: bold;
        }

        #qrModal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            justify-content: center;
            align-items: center;
        }

        #qrModalContent {
            background-color: #394764;
            color: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            width: 450px;
        }

        #progressBar {
            width: 100%;
            background-color: #f3f3f3;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 5px;
            position: relative;
            height: 5px;
        }

        #progress {
            width: 100%;
            height: 100%;
            background-color: #f39c12;
            position: absolute;
            top: 0;
            left: 0;
            animation: progressAnimation 2s linear infinite;
        }

        @keyframes progressAnimation {
            0% {
                left: -100%;
            }
            100% {
                left: 100%;
            }
        }

        .qrModal-footer {
            margin: 15px 30px 10px 30px;
            font-size: 14px;
            display: flex;
            flex-direction: column;
            align-items: center;
            color: white;
        }

        #countdown {
            margin-left: 130px;
        }

        span {
            margin-bottom: 15px;
        }

        .error-message {
            color: red;
        }

        .order-info {
            font-size: 14px;
            font-weight: 700;
            font-family: "Arial", sans-serif;
            margin-bottom: 10px;
        }
        .data{
            font-weight: normal;
        }
    </style>
    <!-- Include Google Places API -->
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places"></script>

</head>
<body>
<jsp:include page="./header/header.jsp"></jsp:include>
<c:url var="pay" value="/PaymentInsertControll"></c:url>

<!-- Checkout Section Begin -->
<section class="shoping-cart spad" >
    <div class="container">
        <div class="checkout__form">
            <h4>Thanh toán</h4>
            <div class="xBNaac"></div>
            <form action="${pay}" id="form" method="get" onsubmit="return validate()">
                <div class="row" style="background-color: white; padding: 10px;">
                    <div class="col-lg-8 col-md-6"
                         style="max-width: 63.666667%; ">
                        <div class="row" style="border-bottom: 1px dashed #e7e7e7;background-color: #fffcf5;height: 130px;border-top-left-radius:12px">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <c:set var="order" value="${sessionScope.bill}"></c:set>
<%--                                    <div class="order-info">Mã đơn hàng: <span class="data">${order.id}</span></div>--%>
                                    <div class="order-info">Ngày đặt hàng: <span class="data" name="bookingDate">${order.bookingDate}</span></div>
                                    <div class="order-info">Địa chỉ giao hàng: <span class="data" name="address">${order.address}</span></div>
                                       <c:if test="${not empty order.orderNotes}">
                                           <div class="order-info">Ghi chú: <span class="data" name="notes">${order.orderNotes}</span>
                                           </div>
                                       </c:if>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <div class="order-info">Họ và tên người nhận: <span id="nameReceive" name="rname" class="data">${order.consigneeName}</span></div>
                                    <div class="order-info">Số điện thoại: <span class="data" name="rphone">${order.consigneePhone}</span></div>
                                        <%--                                    <p>Họ và tên người nhận<span>*</span></p>--%>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="background-color: #fbfbfb;border-radius: 0px 0px 12px 12px">
                            <div class="col-lg-12">
                                <div class="checkoutOrder" style="font-family: 'Arial', sans-serif;font-size: 14px">
                                    <h5 style="text-align: left;margin-top: 15px;margin-bottom: 15px"><b>Danh sách sản phẩm đã đặt</b></h5>
                                    <table>
                                        <thead>
                                        <tr>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${sessionScope.billDetail}" var="orderDetail">
                                            <tr>
                                                <td class="shoping__cart__item">${orderDetail.product.name}</td>
                                                <td class="shoping__cart__price">
                                                    <fmt:formatNumber value="${orderDetail.product.price}" pattern="#,###.### ₫"/>
                                                </td>
                                                <td class="shoping__cart__quantity">${orderDetail.quantity}</td>
                                                <td class="shoping__cart__total">
                                                    <fmt:formatNumber value="${orderDetail.price}" pattern="#,###.### ₫"/>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        </tbody>
                                    </table>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="checkout__order" style="width: 400px">
                            <h5 style="text-align: center;margin-bottom: 15px"><b>Thông tin thanh toán</b></h5>
                            <div class="checkout__order__total">Tổng tiền hàng<span><fmt:formatNumber value="${order.totalMoney}"
                                                                                                      pattern="#,###.### ₫"/></span></div>
                            <div class="checkout__order__total">Phí vận chuyển<span id="shipping-fee"><fmt:formatNumber value="${order.ship}"

                                                                                                                        pattern="#,###.### ₫"/></span></div>
                        <c:if test="${not empty discount}">
                            <div class="checkout__order__total">Voucher từ shop<span><fmt:formatNumber value="${discount}"
                                                                                                       pattern="#,###.### ₫"/></span></div>
                        </c:if>
                        <c:if test="${not empty discount}">
                            <div class="checkout__order__total">Thành tiền<span id="total"><fmt:formatNumber value="${order.totalMoney + order.ship - discount}"
                                                                                                             pattern="#,###.###"/><fmt:formatNumber
                                    value="${total}"
                                    pattern="#,###.###"/>₫</span>
                            </div>
                        </c:if>
                            <c:if test="${empty discount}">
                                <div class="checkout__order__total">Thành tiền<span id="total"><fmt:formatNumber value="${order.totalMoney + order.ship}"
                                                                                                            pattern="#,###.###"/><fmt:formatNumber
                                        value="${total}"
                                        pattern="#,###.###"/>₫</span>
                                </div>
                            </c:if>
                            <input type="hidden" id="total-weight" name="total-weight" value="${totalWeight}">
                            <div class="payment" id="payment-method" style="font-size: 16px;display: block"><b>Chọn hình
                                thức thanh toán</b>
                                <div class="radio-group">
                                    <div class="radio-item">
                                        <input type="radio" id="qr" name="paymentMethod" value="qr">
                                        <label for="qr">Quét mã QR</label>
                                    </div>
<%--                                    <div class="radio-item">--%>
<%--                                        <input type="radio" id="credit" name="paymentMethod" value="credit">--%>
<%--                                        <label for="credit">Thẻ tín dụng/Ghi nợ</label>--%>
<%--                                    </div>--%>
                                    <div class="radio-item">
                                        <input type="radio" id="cod" name="paymentMethod" value="cod">
                                        <label for="cod">Thanh toán khi nhận hàng</label>
                                    </div>
                                </div>
                                <div class="error-message" id="payment-error"></div>
                            </div>
                            <%--                            <c:url var="pay" value="OrderControll"></c:url>--%>
                            <input style="padding: 10px 110px 10px;border: none;margin-top: 10px" type="submit"
                                   class="primary-btn"
                                   value="Thanh toán">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- Modal for QR Code Payment -->
<div id="qrModal">
    <div id="qrModalContent">
        <img id="QRCODE-Img" src="" alt="QR Code" style="width: 80%;border-radius: 20px">
        <h4 style="color: white; text-align: center; margin-top: 15px"><b>Mã QR thanh toán tự động</b></h4>
        <p style="color: white; text-align: center; margin-top: 5px">(Xác nhận tự động - Thường không quá 3')</p>
        <div class="qrModal-footer">
            <%--            <span>Số tiền: <span id="totalPrice"></span></span>--%>
            <%--            <span>Người thụ hưởng: <span id="receiver"></span>CAO THANH TAN</span>--%>
            <%--            <span>Nội dung (bắt buộc): <span id="content"></span></span>--%>
            <span>Đang chờ thanh toán <span id="countdown"></span></span>
            <div id="progressBar">
                <div id="progress"></div>
            </div>
        </div>
    </div>
</div>
<!-- Checkout Section End -->
<script src="../../assets/js/payment.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<!-- Js Plugins -->
<jsp:include page="./footer/footer.jsp"></jsp:include>
<script>
    function validate(){
        const qr = document.getElementById('qr');
        // const credit = document.getElementById('credit');
        const cod = document.getElementById('cod');
        const paymentError = document.getElementById('payment-error');
        let valid = true;

        if (qr) {
            if (cod.checked) {
                paymentError.textContent = '';
            } else {
                paymentError.textContent = 'Vui lòng chọn một hình thức thanh toán';
                valid = false;
            }
            if(qr.checked){
                paymentError.textContent = 'Vui lòng quét mã';
                valid = false;
            }
        }
        return valid;

    }

</script>
</body>
</html>
