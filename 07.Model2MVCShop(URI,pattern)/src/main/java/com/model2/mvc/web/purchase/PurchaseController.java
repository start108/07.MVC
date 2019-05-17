package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;



@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping("/addPurchase")
	public String addPurchaseView() throws Exception {

		System.out.println("/addPurchase");
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping("/addPurchaseView")
	public String addPurchase( @ModelAttribute("purchaseVO") Purchase purchase  ) throws Exception {

		System.out.println("/addPurchaseView");
		//Business Logic
		
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping("/getPurchase")
	public String getPurchase( @RequestParam("tranNo") int tranNo , @RequestParam("menu") String menu, Model model) throws Exception {
		
		System.out.println("/getPurchase");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		if (menu.equals("manage")) {
		
			return "forward:/purchase/updatePurchase.jsp?menu=manage";
		}
			return "forward:/purchase/getPurchase.jsp?menu=search";
	}

	
	
	@RequestMapping("/updatePurchase")
	public String updateProduct( @ModelAttribute("purchase") Purchase purchase  ,Model model, HttpSession session) throws Exception{

		System.out.println("/updatePurchase");
		//Business Logic
		
		purchaseService.updatePurchase(purchase);
	
		return "forward:/purchase/getPurchase.jsp?menu=manage";
	}
//	
//	@RequestMapping("/updateProductView.do")
//	public String updateUserView( @RequestParam("prodNo") int prodno , Model model ) throws Exception{
//
//		System.out.println("/updateProductView.do");
//		//Business Logic
//		Product product = productService.getProduct(prodno);
//		
//		model.addAttribute("product", product);
//		
//		return "forward:/product/updateProduct.jsp";
//	}
//	
	
	
	@RequestMapping("/listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listPurchase");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// 
		Map<String , Object> map=purchaseService.getPurchaseList((Map<String, Object>) search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// 
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}

}