<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <%@ page isELIgnored="false" %>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Golden Fields</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">
    <jsp:include page="link/link.jsp"></jsp:include>
    <style>
        .paging a .active {
            color: #00a045;
            font-weight: bold;
        }

        .product__pagination .pagination .page-item .page-link {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            margin: 0;
            padding: 0;
        }


        .page-btn {
            padding: 10px 23px;
            border-radius: 5px;
            border: none;
            background-color: #ececec;
            color: black;
            font-weight: 700;
        }

        .page-item.active .page-link {
            background-color: #7fad39;
            color: white; /* Đổi màu chữ nếu cần */
        }

        .product-carousel {
            display: flex;
            overflow-x: hidden;
        }

        .product-carousel .product__discount__item {
            flex: 0 0 auto;
            margin-right: 10px; /* Điều chỉnh khoảng cách giữa các sản phẩm */
            width: calc(25% - 10px); /* 4 sản phẩm trên mỗi hàng */
        }

        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: #f1f1f1;
            color: #000;
            padding: 10px;
            border: none;
            outline: none;
            z-index: 1;
        }

        .product-carousel-container {
            display: flex;
            align-items: center;
            position: relative;
        }

        .product-carousel {
            display: flex;
            overflow-x: hidden;
            scroll-behavior: smooth;
            flex-grow: 1;
        }

        .product-carousel .product__discount__item {
            flex: 0 0 auto;
            margin-right: 10px; /* Điều chỉnh khoảng cách giữa các sản phẩm */
            width: calc(25% - 10px); /* 4 sản phẩm trên mỗi hàng */
        }

        .prev, .next {
            cursor: pointer;
            background-color: rgb(212, 213, 215);
            color: #000;
            padding: 10px;
            border: none;
            outline: none;
            position: absolute;
            top: 40%;
            transform: translateY(-50%);
            z-index: 1;
        }

        .prev {
            left: -38px;
        }

        .next {
            right: -25px;
        }

        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
            padding-top: 40px;
        }

        /* Modal content */

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
            max-width: 500px;
            border-radius: 15px;
            position: relative;
        }

        /* Close button */

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* Form styles */

        .data form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #modalProductName {
            font-size: 24px;
            margin-bottom: 20px;
        }

        #modalProductImage {
            margin-bottom: 20px;
        }

        label {
            font-size: 18px;
            margin-bottom: 10px;
        }

        #quantity {
            width: 50px;
            padding: 5px;
            font-size: 16px;
            margin-bottom: 20px;
        }

        button[type="button"] {
            background-color: #8fbe41;
            color: white;
            padding: 15px 20px;
            border: none;
            cursor: pointer;
            font-size: 18px;
            border-radius: 30px;
        }

        button[type="button"]:hover {
            background-color: #94c94d;
        }

        .product__pagination {
            display: flex;
            justify-content: center;
            width: 100%;
            margin-bottom: 20px;
        }

        .page-item {
            margin: 0 2px;
        }

		#content {
			display: flex;
			flex-wrap: wrap;
			justify-content: flex-start; /* Align items to the left */
			width: 100%;
		}

		button[type="button"] {
			background-color: #8fbe41;
			color: white;
			padding: 15px 20px;
			border: none;
			cursor: pointer;
			font-size: 18px;
			border-radius: 30px;
		}
		button[type="button"]:hover {
			background-color: #94c94d;
		}



		.featured__item__pic img {
			width: 100%; /* Đảm bảo hình ảnh chiếm toàn bộ khung */
			border-radius: 10px 10px 0 0; /* Bo tròn góc trên của hình ảnh */
		}

		.featured__item__text {
			margin: -30px 10px 30px 10px; /* Khoảng cách giữa văn bản và khung */
			text-align: center; /* Căn giữa văn bản */
		}

		.buy-now-btn {
			padding: 10px 23px;
			border-radius: 30px;
			border: none;
			background-color: #7fad39;
			font-weight: 700;
			color: #ffffff;
			margin-top: 7px; /* Khoảng cách trên giữa nút và văn bản */
		}

		/*.product-frame {*/
		/*	border: 2px solid #d4d5d7;*/
		/*	padding: 20px 10px 0px 10px;*/
		/*	box-sizing: border-box;*/
		/*	border-radius: 15px;*/
		/*	box-shadow: 0 4px 8px rgba(0.1, 0.1, 0.1, 0.1); !* Subtle shadow effect *!*/
		/*	height: 250px;*/

		/*}*/
		/*.product-frame:hover {*/
		/*	border: 2px solid #d4d5d7;*/
		/*	padding: 20px 10px 0px 10px;*/
		/*	box-sizing: border-box;*/
		/*	border-radius: 15px;*/
		/*	box-shadow: 0 4px 8px rgba(0.5, 0.5, 0.5, 0.5); !* Subtle shadow effect *!*/
		/*	height: 250px;*/

		/*}*/

         .out-of-stock-overlay {
             position: absolute;
             top: 0;
             left: 0;
             width: 100%;
             height: 300px;
             background-color: rgba(255, 255, 255, 0.6);
             color: red;
             font-weight: bold;
             display: flex;
             align-items: center;
             justify-content: center;
             z-index: 10;
             font-size: 20px;
         }
        .product-frame {
            position: relative; /* Ensure the overlay is positioned relative to the product image */
        }
        .out-of-stock-text {
            /*background-color: rgba(26, 26, 26, 0.7); !* White background for the text *!*/
            padding: 5px; /* Padding around the text */
            border-radius: 5px; /* Slightly rounded corners */
            color: red; /* Text color */
            font-weight: bold;
            margin-top: 60px; /* Move text down by 30px */


        }
	</style>

</head>

<body>
<c:url var="detail" value="DetailControl"></c:url>

<span class="header__fixed">
	<jsp:include page="header/header.jsp"></jsp:include>
</span>

<!-- Breadcrumb Section Begin -->

<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="assets/img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Sản phẩm</h2>
                    <div class="breadcrumb__option">
                        <a href="./IndexControll">Trang chủ</a>
                        <span>Sản phẩm </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Product Section Begin -->
<section class="product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-5">
                <div class="sidebar">
                    <div class="sidebar__item">
                        <h4>Những loại rau quả</h4>
                        <ul>

                            <li><a href="#">Rau xanh lá</a></li>
                            <li><a href="#">Quả dâu</a></li>
                            <li><a href="#">Quả lựu</a></li>
                            <li><a href="#">Quả lê</a></li>
                            <li><a href="#">Quả táo</a></li>
                            <li><a href="#">Cà chua</a></li>
                            <li><a href="#">Cà rốt</a></li>
                            <li><a href="#">Bí đỏ</a></li>
                            <li><a href="#">Bơ</a></li>
                            <li><a href="#">Cải bắp cải</a></li>
                        </ul>
                    </div>
                    <div class="sidebar__item sidebar__item__color--option">
                        <h5><b>LỌC SẢN PHẨM</b></h5>
                        <div id="filter" class="filter-container">
                            <form id="filterForm">
                                <fieldset style="border: 2px solid #82ae46;">
                                    <legend style="width:150px; font-size: 18px;">Danh mục</legend>
                                    <label style="display: block; margin-bottom: 10px; margin-left: 10px">
                                        <input type="radio" class="cate_Filter" name="category" value="1"> Mục 1
                                    </label>
                                    <label style="display: block; margin-bottom: 10px;margin-left: 10px">
                                        <input type="radio" class="cate_Filter" name="category" value="2"> Mục 2
                                    </label>
                                    <label style="display: block; margin-bottom: 10px;margin-left: 10px">
                                        <input type="radio" class="cate_Filter" name="category" value="3"> Mục 3
                                    </label>
                                </fieldset>

                                <fieldset style="border: 2px solid #82ae46;">
                                    <legend style="width: 150px; font-size: 18px;">Khoảng giá</legend>
                                    <div style="display: flex;">
                                        <label style="display: block; margin-bottom: 10px;margin-left: 10px">
                                            <input type="number" class="price_fromFilter" name="price_from"
                                                   placeholder="Từ" style="width: 100px;">
                                        </label>
                                        <label style="display: block; margin-bottom: 10px; margin-right: 10px;margin-left: 10px">
                                            <input type="number" class="price_toFilter" name="price_to"
                                                   placeholder="Đến" style="width: 100px;">
                                        </label>
                                    </div>
                                </fieldset>

								<fieldset style="border: 2px solid #82ae46;">
									<legend style="width: 150px; font-size: 18px;">Địa chỉ</legend>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="provider_sortFilter" name="provider" value="1"> Thành phố HCM
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="provider_sortFilter" name="provider" value="2"> Đà Nẵng
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="provider_sortFilter" name="provider" value="3"> Hà Nội
									</label>
									<label style="display: block; margin-bottom: 10px;margin-left: 10px">
										<input type="radio" class="provider_sortFilter" name="provider" value="4"> Nghệ An
									</label>
								</fieldset>
								<button class="btn btn-success" style="margin-top: 5px" type="submit" value="Lọc">Lọc</button>

								<button  class="btn btn-danger" style="margin-top: 5px" onclick="resetFilters()">Hủy</button>

							</form>

						</div>
					</div>



                    <div class="sidebar__item">
                        <h4>Popular Size</h4>
                        <div class="sidebar__item__size">
                            <label for="large">
                                Large
                                <input type="radio" id="large">
                            </label>
                        </div>
                        <div class="sidebar__item__size">
                            <label for="medium">
                                Medium
                                <input type="radio" id="medium">
                            </label>
                        </div>
                        <div class="sidebar__item__size">
                            <label for="small">
                                Small
                                <input type="radio" id="small">
                            </label>
                        </div>
                        <div class="sidebar__item__size">
                            <label for="tiny">
                                Tiny
                                <input type="radio" id="tiny">
                            </label>
                        </div>
                    </div>

                    <div class="sidebar__item">

                        <div class="latest-product__text">
                            <h4>Latest Products</h4>
                            <div class="latest-product__slider owl-carousel">

                            </div>
                        </div>
                    </div>
                </div>

			</div>
			<div class="col-lg-9 col-md-7">
				<div class="product__discount">
					<div class="section-title product__discount__title">
						<h2>Giảm giá</h2>
					</div>
					<div class="row">
						<div class="product-carousel-container">
							<button class="prev" onclick="scrollCarousel(-1)">&#10094;</button>
							<div class="product-carousel">
								<c:forEach var="b" items="${listSale}">
									<div class="product__discount__item">
										<div class="product__discount__item__pic set-bg" data-setbg="${b.image}">
											<div class="product__discount__percent">-20%</div>
										</div>
										<div class="product__discount__item__text">
											<span>Dried Fruit</span>
											<h5><a href="${detail}?pid=${b.id}">${b.name}</a></h5>
											<div class="product__item__price">${b.price} <span>$30.00</span></div>
										</div>
									</div>
								</c:forEach>
							</div>
							<button class="next" onclick="scrollCarousel(1)">&#10095;</button>
						</div>
					</div>
				</div>
				<div class="filter__item">
					<div class="row">
						<div class="col-lg-4 col-md-5">
							<div class="filter__sort">
								<form class="form-inline form-viewpro" id="productForm">
									<input type="hidden" name="cid" value="${cid}">
									<span>Sắp xếp theo</span>
									<select class="sort-by-script" name="sort" id="selectFilter">
										<option value="id-asc" <c:if test="${sort=='id-asc'}">selected</c:if>>Mặc định</option>
										<option value="price-asc" <c:if test="${sort=='price-asc'}">selected</c:if>>Giá tăng dần</option>
										<option value="price-desc" <c:if test="${sort=='price-desc'}">selected</c:if>>Giá giảm dần</option>
										<option value="name-asc" <c:if test="${sort=='name-asc'}">selected</c:if>>A-Z</option>
										<option value="name-desc" <c:if test="${sort=='name-desc'}">selected</c:if>>Z-A</option>
									</select>
								</form>
							</div>
						</div>
						<div class="col-lg-4 col-md-4">
							<div class="filter__found">
								<h6> Sản phẩm được tìm thấy</h6>
							</div>
						</div>
						<div class="col-lg-4 col-md-3">
							<div class="filter__option">
								<span class="icon_grid-2x2"></span>
								<span class="icon_ul"></span>
							</div>
						</div>
					</div>
				</div>
                <div class="row" id="content">
                    <c:forEach items="${listProducts}" var="o">
                        <div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
                            <div class="product-col">
                                <div class="featured__item">
                                    <div class="product-frame">
<%--                                        <c:if test="${productCurrentQuantities[o.id] <=0}">--%>
<%--                                            <div class="out-of-stock-overlay">--%>
<%--                                                <span class="out-of-stock-text">Hết hàng</span>--%>
<%--                                            </div>--%>
<%--                                        </c:if>--%>
                                        <div class="featured__item__pic set-bg" >
                                            <a href="${detail}?pid=${o.id}">
                                                <img src="${o.image}" alt="${o.name}">
                                            </a>
                                        </div>
                                        <div class="featured__item__text">
                                            <a class="product-name" href="${detail}?pid=${o.id}" style="color: black">
                                                    ${o.name}
                                            </a>
                                            <h5><fmt:formatNumber value="${o.price}" pattern="#,###.### ₫"/></h5>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <c:url var="addToCart" value="/AddToCartControl"></c:url>
                                        <form action="${addToCart}?pid=${o.id}" method="post" enctype="multipart/form-data">
                                            <button class="buy-now-btn"
                                                    data-product-id="${o.id}"
                                                    data-product-name="${o.name}"
                                                    data-product-image="${o.image}"
                                                    style="padding: 10px 23px; border-radius: 30px; border: none; background-color: #7fad39; font-weight: 700; color: #ffffff">
                                                MUA NGAY
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>




                <!-- Modal Form -->
                <div id="myModal" class="modal">
                    <div class="modal-content">
                        <div class="exit"><span class="close">&times;</span></div>
                        <div class="data">
                            <form id="addToCartForm" action="/AddToCartControl" method="post">
                                <input type="hidden" id="productId" name="pid">
                                <h3 id="modalProductName"></h3>
                                <img id="modalProductImage" src="" style="width: 30vh;height: 30vh" alt="Product Image">
                                <label for="quantity">Số lượng:</label>
                                <input type="number" id="quantity" name="quantity" value="1" min="1">
                                <button type="button" id="addToCartButton">Thêm vào giỏ hàng</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!---End Modal-->
                <!-- Pagination -->
                <div class="product__pagination">
                    <ul class="pagination" style=" margin-left: 300px;">

                        <c:forEach begin="1" end="${endPage}" var="i">
                            <li class="page-item  <c:if test='${i == page}'>active</c:if>">
                                <a class="page-link page-btn" href="javascript:void(0);">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Product Section End -->
<jsp:include page="footer/footer.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var modal = document.getElementById('myModal');
        var span = document.getElementsByClassName('close')[0];

        document.querySelectorAll('.buy-now-btn').forEach(function (button) {
            button.addEventListener('click', function (event) {
                event.preventDefault();
                var productId = button.getAttribute('data-product-id');
                var productName = button.getAttribute('data-product-name');
                var productImage = button.getAttribute('data-product-image');

                document.getElementById('productId').value = productId;
                document.getElementById('modalProductName').textContent = productName;
                document.getElementById('modalProductImage').setAttribute('src', productImage);

                modal.style.display = 'block';
            });
        });

        span.onclick = function () {
            modal.style.display = 'none';
        };

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        };
    });

    document.addEventListener('DOMContentLoaded', function () {
        // Lắng nghe sự kiện click vào nút "Thêm vào giỏ hàng"
        document.getElementById('addToCartButton').addEventListener('click', function () {
            // Lấy giá trị của productId và quantity từ form
            var productId = document.getElementById('productId').value;
            var quantity = document.getElementById('quantity').value;

            // Tạo đối tượng XMLHttpRequest để gửi request Ajax
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/AddToCartControl', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

            // Xử lý khi nhận được phản hồi từ server
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // Xử lý phản hồi từ server (nếu cần)
                        var response = JSON.parse(xhr.responseText);

                        // Ví dụ: hiển thị thông báo cho người dùng
                        alert('Sản phẩm đã được thêm vào giỏ hàng thành công!');

                        // Cập nhật size giỏ hàng
                        document.getElementById('cart-count').innerText = response.size;

                        // Đặt lại giá trị của trường số lượng về 1
                        document.getElementById('quantity').value = 1;

                        // Đóng modal (nếu có)
                        closeModal();
                    } else {
                        // Xử lý lỗi (nếu có)
                        alert('Đã xảy ra lỗi khi thêm sản phẩm vào giỏ hàng.');
                    }
                }
            };

            // Gửi dữ liệu form lên server
            var formData = 'pid=' + encodeURIComponent(productId) + '&quantity=' + encodeURIComponent(quantity);
            xhr.send(formData);
        });

        // Hàm đóng modal
        function closeModal() {
            var modal = document.getElementById('myModal');
            modal.style.display = 'none';
        }
    });

</script>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        var buttons = document.querySelectorAll('.page-btn');
        buttons.forEach(function (button) {
            button.addEventListener('click', function () {
                buttons.forEach(function (btn) {
                    btn.classList.remove('active');
                });
                this.classList.add('active');
            });
        });
    });

</script>
<script>
    function scrollCarousel(direction) {
        const carousel = document.querySelector('.product-carousel');
        const itemWidth = carousel.querySelector('.product__discount__item').clientWidth + 10; // Bao gồm cả margin-right

        if (direction === 1) {
            // Cuộn sang phải
            if (carousel.scrollLeft + carousel.clientWidth >= carousel.scrollWidth) {
                // Nếu đang ở cuối, cuộn lại đầu
                carousel.scrollTo({left: 0, behavior: 'smooth'});
            } else {
                carousel.scrollBy({left: itemWidth, behavior: 'smooth'});
            }
        } else {
            // Cuộn sang trái
            if (carousel.scrollLeft === 0) {
                // Nếu đang ở đầu, cuộn đến cuối
                carousel.scrollTo({left: carousel.scrollWidth, behavior: 'smooth'});
            } else {
                carousel.scrollBy({left: -itemWidth, behavior: 'smooth'});
            }
        }
    }

</script>
<script>
    function loadFilteredProducts(sort, page) {
        var cid = '${param.cid}';
        var category = $('input[name="category"]:checked').val();
        var priceFrom = $('input[name="price_from"]').val();
        var priceTo = $('input[name="price_to"]').val();
        var provider = $('input[name="provider"]:checked').val();

        $.ajax({
            url: 'ShowProductControl',
            type: 'GET',
            data: {
                cid: cid,
                sort: sort,
                category: category,
                price_from: priceFrom,
                price_to: priceTo,
                provider: provider,
                page: page
            },
            success: function (response) {
                $('#content').html(response.html);
                updatePaging(response.currentPage, response.totalPages); // Update pagination
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    }

    function loadPage(page) {
        var sortValue = $('#selectFilter').val();
        loadFilteredProducts(sortValue, page);
    }

    function updatePaging(currentPage, totalPages) {
        var paginationHtml = '';
        for (var i = 1; i <= totalPages; i++) {
            paginationHtml += '<li class="page-item ' + (i == currentPage ? 'active' : '') + '">';
            paginationHtml += '<a class="page-link page-btn" href="javascript:void(0);">' + i + '</a>';
            paginationHtml += '</li>';
        }
        $('.pagination').html(paginationHtml);
    }

    $(document).ready(function () {
        // Handle sorting change event
        $('#selectFilter').change(function () {
            loadFilteredProducts($(this).val(), 1); // Load first page when sort changes
        });

        // Handle pagination click event
        $(document).on('click', '.page-btn', function () {
            var page = $(this).text();
            loadPage(page); // Load selected page
        });

        // Handle filter form submission
        $('#filterForm').submit(function (event) {
            event.preventDefault(); // Prevent default form submission
            var sortValue = $('#selectFilter').val();
            loadFilteredProducts(sortValue, 1); // Load first page with selected filters
        });
    });
</script>
<script>
	function resetFilters() {
		// Bỏ chọn tất cả các radio button
		const radioButtons = document.querySelectorAll('input[type="radio"]');
		radioButtons.forEach(radio => {
			radio.checked = false;
		});

		// Xóa giá trị của tất cả các input number
		const numberInputs = document.querySelectorAll('input[type="number"]');
		numberInputs.forEach(input => {
			input.value = '';
		});
	}
</script>
<!-- Js Plugins -->
<script src="assets/js/jquery-3.3.1.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/jquery-ui.min.js"></script>
<script src="assets/js/jquery.slicknav.js"></script>
<script src="assets/js/mixitup.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/main.js"></script>

</body>

</html>