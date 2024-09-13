package controller.client.cart;

import dao.client.ProductDAO;
import model.Account;
import model.Cart;
import model.OrderDetail;
import model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AddToCartControl", value = "/AddToCartControl")
public class AddToCartControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        String productId = request.getParameter("pid");
        int pid = Integer.parseInt(productId);

        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/LoginControll");
        } else {
            int quantity = 1;
            Product product = ProductDAO.getProductById(pid);
            String getQuantity = request.getParameter("quantity");
            if (getQuantity != null) {
                quantity = Integer.parseInt(getQuantity);
            }

            // Đọc giỏ hàng từ cookie
            Map<Integer, OrderDetail> cart = Cart.readCartFromCookies(request, account.getId());

            // Cập nhật giỏ hàng
            OrderDetail orderDetail = cart.get(pid);
            if (orderDetail == null) {
                orderDetail = new OrderDetail();
                orderDetail.setProduct(product);
                orderDetail.setProductPrice(product.getPrice());
                orderDetail.setQuantity(quantity);
                orderDetail.setPrice(product.getPrice() * quantity);

                cart.put(pid, orderDetail);
            } else {
                orderDetail.setQuantity(orderDetail.getQuantity() + quantity);
            }

            // Lưu giỏ hàng vào cookie
            Cart.writeCartToCookies(request, response, cart, account.getId());

            // Trả về JSON chứa kích thước giỏ hàng
            int sizeCart = cart.size();
//            Cart.writeSizeCartToCookies(response,sizeCart);
            session.setAttribute("size", sizeCart);
            response.getWriter().write("{\"size\":" + sizeCart + "}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }


}
