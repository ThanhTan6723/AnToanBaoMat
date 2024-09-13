package controller.client.order;

import dao.client.OrderDAO;
import model.Account;
import model.Cart;
import model.Order;
import model.OrderDetail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PaymentInsertControll", value = "/PaymentInsertControll")
public class PaymentInsertControll extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        Account account = (Account) session.getAttribute("account");
        Order order = (Order) session.getAttribute("bill");
        List<OrderDetail> orderDetail = (List<OrderDetail>) session.getAttribute("billDetail");

        if (order != null && order != null) {
            OrderDAO.insertOrder(order);
            OrderDAO.setCurrentIdBill(order);
            for (OrderDetail od : orderDetail) {
                od.setOrder(order);
                OrderDAO.insertOrderdetail(od);
            }
            Cart.deleteCartToCookies(request, response, account.getId());
            session.setAttribute("size", 0);
            response.sendRedirect(request.getContextPath() + "/CheckOutSuccessControll");
        } else {
            request.getRequestDispatcher("/WEB-INF/client/payment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}