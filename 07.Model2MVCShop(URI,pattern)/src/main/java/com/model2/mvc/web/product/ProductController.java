package com.model2.mvc.web.product;

import java.util.Map;

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
import com.model2.mvc.service.product.ProductService;


//==> 占쎌돳占쎌뜚�꽴占썹뵳占� Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method �뤃�뗭겱 占쎈륫占쎌벉
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 筌〓챷�� 占쎈막野껓옙
	//==> 占쎈툡占쎌삋占쎌벥 占쎈あ揶쏆뮆占쏙옙 雅뚯눘苑랃옙�뱽 占쏙옙占쎈선 占쎌벥沃섎챶占쏙옙 占쎌넇占쎌뵥 占쎈막野껓옙
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping("addProductView")
	public String addProductView() throws Exception {

		System.out.println("addProductView");
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping("addProduct")
	public String addProduct( @ModelAttribute("productVO") Product product ) throws Exception {

		System.out.println("addProduct");
		//Business Logic
		String manuDate = product.getManuDate().replaceAll("-","");
		product.setManuDate(manuDate);
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping("getProduct")
	public String getProduct( @RequestParam("prodNo") int prodNo , @RequestParam("menu") String menu, Model model) throws Exception {
		
		System.out.println("getProduct");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 怨� View瑜� �뿰寃고븯�뒗 addAttribute==> jsp�뿉�꽌 �궗�슜�븯�젮硫� product濡� �뜥二쇱뼱�빞 �븿
		model.addAttribute("product", product);
		
		if (menu.equals("manage")) {
		
			return "forward:/product/updateProduct.jsp?menu=manage";
		}
			return "forward:/product/getProduct.jsp?menu=search";
	}

		
	
	@RequestMapping("updateProduct")
	public String updateProduct( @ModelAttribute("product") Product product  ,Model model, HttpSession session) throws Exception{

		System.out.println("updateProduct");
		//Business Logic
		
		productService.updateProduct(product);
	
		return "forward:/product/getProduct.jsp?menu=manage";
	}
	
	@RequestMapping("updateProductView")
	public String updateUserView( @RequestParam("prodNo") int prodno , Model model ) throws Exception{

		System.out.println("updateProductView");
		//Business Logic
		Product product = productService.getProduct(prodno);
		// Model �⑨옙 View 占쎈염野껓옙
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	
	
	@RequestMapping("listProduct")
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("listProduct");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 占쎈땾占쎈뻬
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �⑨옙 View 占쎈염野껓옙
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}

}