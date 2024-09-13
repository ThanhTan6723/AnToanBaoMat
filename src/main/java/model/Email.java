package model;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {

	static final String from = "feanfoodkorea@gmail.com";
	static final String password = "mvfe qrhy crej mbks";

	public static boolean sendEmail(String to, String title, String code) {
		// Properties
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
		props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		// create Authenticator
		Authenticator auth = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// TODO Auto-generated method stub
				return new PasswordAuthentication(from, password);
			}
		};

		Session session = Session.getInstance(props, auth);

		// create a message
		MimeMessage msg = new MimeMessage(session);

		try {
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

			// sender
			msg.setFrom(from);

			// receiver
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

			// title
			msg.setSubject(title);

			// set date
			msg.setSentDate(new Date());

			// msg.setReplyTo(InternetAddress.parse(from, false))

			// content
			msg.setContent(code, "text/HTML; charset=UTF-8");

			// send email
			Transport.send(msg);
			System.out.println("send email successful");
			return true;
		} catch (Exception e) {
			System.out.println("send email error");
			e.printStackTrace();
			return false;
		}
	}

	// test
//	public static void main(String[] args) {
//			Email.sendEmail("thanhtan8900@gmail.com", "Verifycation", "Đây là phần nội dung!");
//
//	}

}
