package controller.client.order;

import com.google.gson.Gson;
import dao.client.OrderDAO;
import model.Account;
import model.OrderDetail;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

@WebServlet("/LoadOrderContentServlet")
public class LoadOrderContentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        List<OrderDetail> orderDetails = new ArrayList<>();

        String orderStatus = request.getParameter("status");
        System.out.println(orderStatus);

        if (orderStatus.equals("all")) {
            orderDetails = OrderDAO.getListOrder(account.getId());
        } else {
            orderDetails = OrderDAO.getOrderDetailsByStatus(orderStatus);
        }
        System.out.println(orderDetails);

        String json = new Gson().toJson(orderDetails);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
