$(document).ready(function() {
    // Load all orders by default
    loadOrders('all');

    // Handle tab click event
    $('.nav-tabs a').click(function(event) {
        event.preventDefault();
        var status = $(this).data('status');
        console.log(status);
        // Highlight the active tab
        $('.nav-tabs a').removeClass('active');
        $(this).addClass('active');

        // Load orders by status
        loadOrders(status);
    });
});

function formatNumber(value) {
    return value.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
}

function loadOrders(status) {
    $.ajax({
        url: 'LoadOrderContentServlet',
        method: 'GET',
        data: {
            status: status
        },
        success: function(response) {
            console.log(response);
            var ordersHtml = '<div class="row" style="background-color: white; padding: 10px;">';

            if (response.length === 0) {
                ordersHtml += `
                    <div class="col-lg-12">
                        <div class="empty" style="text-align: center; padding: 80px;">
                            <h4 style="color: #8f8f8f">Bạn chưa có đơn hàng nào</h4>
                        </div>
                    </div>
                `;
            } else {
                var currentOrderId = null;

                $.each(response, function(index, orderDetail) {
                    if (orderDetail.order.id !== currentOrderId) {
                        // Set new currentOrderId
                        currentOrderId = orderDetail.order.id;

                        ordersHtml += `
                         <div class="col-lg-12 col-md-6">
                            <div class="row" style="border-bottom: 1px dashed #e7e7e7; background-color: #fffcf5; height: 180px;;margin-top: 30px">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <div class="order-info">Mã đơn hàng: <span class="data" id="order-id">${orderDetail.order.id}</span></div>
                                        <div class="order-info">Ngày đặt hàng: <span class="data">${orderDetail.order.bookingDate}</span></div>
                                        ${orderDetail.order.diliveryDate ? `<div class="order-info">Ngày giao hàng: <span class="data">${orderDetail.order.diliveryDate}</span></div>` : ''}
                                        <div class="order-info">Địa chỉ giao hàng: <span class="data">${orderDetail.order.address}</span></div>
                                        <div class="order-info">Trạng thái đơn hàng: <span class="data" style="color: #7ed000;">${orderDetail.order.orderStatus}</span></div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <div class="order-info">Họ và tên người nhận: <span id="nameReceive" class="data">${orderDetail.order.consigneeName}</span></div>
                                        <div class="order-info">Số điện thoại: <span class="data">${orderDetail.order.consigneePhone}</span></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="border-bottom: 1px dashed #e7e7e7; background-color: #fbfbfb;">
                                <div class="col-lg-12">
                                    <div class="checkoutOrder" style="font-family: 'Arial', sans-serif; font-size: 14px;">
                                        <h5 style="text-align: left; margin-top: 15px; margin-bottom: 15px;"><b>Danh sách sản phẩm đã đặt</b></h5>
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Tên sản phẩm</th>
                                                    <th>Hình ảnh</th>
                                                    <th>Giá</th>
                                                    <th>Số lượng</th>
                                                    <th>Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>`;
                    }

                    // Add product row
                    ordersHtml += `
                        <tr>
                            <td class="shoping__cart__item">${orderDetail.product.name}</td>
                            <td class="shoping__cart__item"><img src="${orderDetail.product.image}" style="border-radius: 30px;"></td>
                            <td class="shoping__cart__price">${formatNumber(orderDetail.product.price)}</td>
                            <td class="shoping__cart__quantity">x${orderDetail.quantity}</td>
                            <td class="shoping__cart__price">${formatNumber(orderDetail.price)}</td>
                        </tr>`;

                    // If it's the last item or the next order is different, close the table
                    if (index === response.length - 1 || orderDetail.order.id !== response[index + 1].order.id) {
                        ordersHtml += `
                            </tbody>
                            </table>
                            </div>
                            </div>
                            </div>
                            <div class="row" style="background-color: #fbfbfb; height: 190px; margin-bottom: 30px; border-bottom-left-radius: 35px;">
                                <div class="col-lg-12">
                                    <div class="payment-order" style="display: flex; flex-direction: column; align-items: flex-end; margin-right: 30px; margin-top: 30px;">
                                        <div class="order-info">Tổng tiền hàng: <span class="data">${formatNumber(orderDetail.order.totalMoney)}</span></div>
                                        <div class="order-info">Phí vận chuyển: <span class="data">${formatNumber(orderDetail.order.ship)}</span></div>
                                         ${orderDetail.order.discountValue != 0 ? `
    <div class="order-info">
        Giảm giá: <span style="color: red;" class="data">${formatNumber(orderDetail.order.discountValue)}</span>
    </div>
` : ``}

<div class="order-info">
    Thành tiền: <span style="color: red;" class="data">
        ${formatNumber(orderDetail.order.totalMoney + orderDetail.order.ship - (orderDetail.order.discountValue || 0))}
    </span>
</div>

${orderDetail.order.orderStatus === 'Đơn hàng đang chờ xác nhận' || orderDetail.order.orderStatus === 'Đơn hàng đã được xác nhận và chờ đóng gói' ? `
    <div class="order-info">
        <!-- Thêm nội dung tại đây cho đơn hàng đang chờ xác nhận hoặc đã xác nhận -->
    </div>
` : ``}

                                        ${orderDetail.order.orderStatus === 'Đơn hàng đang chờ xác nhận' || orderDetail.order.orderStatus === 'Đơn hàng đã được xác nhận và chờ đóng gói' ? `
                                        <div class="order-info">
                                            <button class="action" style="border: none; padding: 8px; background-color: #85ab1a; color: white; border-radius: 25px;" onclick="sendCancelRequest(${orderDetail.order.id})">
                                                <b>Gửi yêu cầu hủy</b>
                                            </button>
                                        </div>` : ''}
                                        ${orderDetail.order.orderStatus === 'Yêu cầu hủy' ? `
                                        <div class="order-info">
                                            <button disabled class="action" style="border: none; padding: 8px; background-color: #cbcbcb; color: white; border-radius: 25px;">
                                                <b>Đang xác nhận hủy</b>
                                            </button>
                                        </div>` : ''}
                                    </div>
                                </div>
                            </div>
                           </div>`;
                    }
                });
            }

            ordersHtml += '</div>';
            $('#order-list-container').html(ordersHtml);
        },
        error: function(xhr, status, error) {
            console.log(error);
        }
    });
}
