//package model;
//
//import org.json.JSONObject;
//
//import javax.servlet.http.HttpServletRequest;
//import java.net.HttpURLConnection;
//import java.net.InetAddress;
//import java.net.NetworkInterface;
//import java.net.URL;
//import java.util.Enumeration;
//import java.util.Scanner;
//
//public class GetNationalAddress {
//
//    public static String getClientIp(HttpServletRequest request) {
//        String[] headerNames = {
//                "X-Forwarded-For",
//                "X-Real-IP",
//                "Proxy-Client-IP",
//                "WL-Proxy-Client-IP",
//                "HTTP_CLIENT_IP",
//                "HTTP_X_FORWARDED_FOR"
//        };
//
//        for (String header : headerNames) {
//            String ip = request.getHeader(header);
//            if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
//                return ip;
//            }
//        }
//        return request.getRemoteAddr();
//    }
//    public static String getCountryFromIp(String ip) {
//        try {
//            URL url = new URL("https://ipapi.co/" + ip + "/json/");
//            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//            conn.setRequestMethod("GET");
//            conn.connect();
//
//            // Check if connect is made
//            int responseCode = conn.getResponseCode();
//            if (responseCode == 429) {
//                // Handle rate limit exceeded error
//                throw new RuntimeException("Rate limit exceeded. HTTP Response Code: 429");
//            } else if (responseCode != 200) {
//                throw new RuntimeException("HTTP Response Code: " + responseCode);
//            } else {
//                StringBuilder inline = new StringBuilder();
//                Scanner scanner = new Scanner(url.openStream());
//
//                // Write all the JSON data into a string using a scanner
//                while (scanner.hasNext()) {
//                    inline.append(scanner.nextLine());
//                }
//                scanner.close();
//
//                // Using the JSON simple library parse the string into a json object
//                JSONObject data = new JSONObject(inline.toString());
//                return data.getString("country_name");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "Unknown";
//        }
//    }
//
//    public static void main(String[] args) {
//        String ip = "10.50.1.226"; // Replace with actual IP address
//        try {
//            String country = getCountryFromIp(ip);
//            System.out.println("Country: " + country);
//        } catch (RuntimeException e) {
//            System.err.println("Error: " + e.getMessage());
//        }
//    }
//}
