package kr.spring.assignment.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.assignment.service.AssignService;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AssignBoardController {

	@Autowired
	private AssignService assignservice;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public AssignVO initCommand() {
		return new AssignVO();
	}
	
	/*====================
	 *양도게시판 글작성
	 =====================*/
	@GetMapping("/assignboard/write")
	public String assignform() {
		return "assignWrite";
	}
	//등록 폼에서 전송된 데이터 처리
	@PostMapping("/assignboard/write")
	public String submit(@Valid AssignVO assignVO, BindingResult result,
						HttpServletRequest request, HttpSession session, Model model)throws IllegalStateException,IOException{
		log.debug("<<게시판 글 등록>> : " + assignVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return assignform();
		}
		
		//회원번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		assignVO.setMem_num(vo.getMem_num());
		//ip 셋팅
		assignVO.setAb_ip(request.getRemoteAddr());
		
		//글쓰기
		assignservice.ab_insertBoard(assignVO);
		
		//View 메시지 처리
		model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/assignboard/list");
		return "common/resultAlert";
		}
		
	
	/*====================
	 *양도게시판 목록
	 =====================*/
	@GetMapping("/assignboard/list")
	public String getList(@RequestParam(defaultValue="1") int pageNum,
						  @RequestParam(defaultValue="1") int order,
						  String keyfield, String keyword, Model model) {
		log.debug("<<게시판 목록 - order>> : " + order);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체, 검색 레코드수
		int count = assignservice.ab_selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,10,10,"list");
		List<AssignVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = assignservice.ab_selectList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
			
		return "assignList";
	}
	
	/*====================
	 *양도게시판 글상세
	 =====================*/
	@GetMapping("/assignboard/detail")
	public ModelAndView process() {
		
		
		return new ModelAndView("assignView");
	}
	
	
}
