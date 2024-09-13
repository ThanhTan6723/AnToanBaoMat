package controller.i18n;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/I18N")
public class Internationalize extends HttpServlet {

	private static final Map<String, String> REDIRECT_MAP = new HashMap<>();
	static {
		REDIRECT_MAP.put("ShowProductControl?cid=0", "ShowProductControl?cid=0");
		REDIRECT_MAP.put("/client/checkout-success.jsp", "/client/checkout-success.jsp");
		REDIRECT_MAP.put("LoginControll", "LoginControll");
		REDIRECT_MAP.put("IndexControl", "IndexControl");
		REDIRECT_MAP.put("ChangePassword", "ChangePassword");
		REDIRECT_MAP.put("IntroduceControll", "IntroduceControll");
		REDIRECT_MAP.put("ContactControll", "ContactControll");
		REDIRECT_MAP.put("CheckOutControll", "CheckOutControll");
		REDIRECT_MAP.put("OrderPlaceControl", "OrderPlaceControl");
		REDIRECT_MAP.put("CartControll", "CartControll");
		REDIRECT_MAP.put("ForgotControll", "ForgotControll");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String lang = request.getParameter("lang");
		HttpSession session = request.getSession();
		session.setAttribute("lang", lang);

		String referer = request.getHeader("Referer");
		int[] cids = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };

		if (referer != null) {
			for (Map.Entry<String, String> entry : REDIRECT_MAP.entrySet()) {
				String targetUrl = entry.getKey();
				if (referer.endsWith(targetUrl)) {
					response.sendRedirect(entry.getValue());
					return;
				}
			}

			for (int cid : cids) {
				String targetUrl = "AddToCartControll?pid=" + cid;
				if (referer.endsWith(targetUrl)) {
					response.sendRedirect(targetUrl);
					return;
				}
			}

			for (int cid : cids) {
				String targetUrl = "DetailControl?pid=" + cid;
				if (referer.endsWith(targetUrl)) {
					response.sendRedirect(targetUrl);
					return;
				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
