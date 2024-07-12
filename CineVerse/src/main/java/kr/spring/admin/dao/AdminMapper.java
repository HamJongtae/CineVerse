package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;

@Mapper
public interface AdminMapper {
    // 회원 관리
    @Select("SELECT m.mem_num, m.mem_id, m.mem_auth, m.mem_rank, m.mem_membership, "
            + "md.mem_name, md.mem_phone, md.mem_email, md.mem_reg_date "
            + "FROM member m "
            + "JOIN member_detail md ON m.mem_num = md.mem_num WHERE m.mem_auth = 3 ORDER BY md.mem_reg_date DESC")
    public List<AdminVO> getAllMembers();
    
    public void updateAuth(long mem_num, long mem_auth);
    
    // 구독 맴버십
    @Select("SELECT m.mem_num, m.mem_id, m.mem_rank, m.mem_membership, md.mem_name, md.mem_reg_date "
    		+ "FROM member m Join member_detail md "
    		+ "ON m.mem_num = md.mem_num WHERE m.mem_membership = 1 ORDER BY md.mem_reg_date DESC")
    public List<AdminVO> getAllMembership();
    // 공지사항
    @Select("SELECT nb_num, nb_title, nb_content, nb_filename, nb_reg_date "
    		+ "FROM notice_board "
    		+ "ORDER BY nb_reg_date DESC")
    public List<NoticeVO> getAllNotice();
    public void insertNotice(NoticeVO noticeVO);
    
    // 이벤트
    @Select("SELECT event_num, event_name, event_start, event_end, event_reg_date "
    		+ "FROM event "
    		+ "ORDER BY event_reg_date DESC")
    public List<EventVO> getAllEvent();
    public void insertEvent(EventVO eventVO);
	
    // 결제
    // 게시판
    @Select("SELECT cb_num, mem_num, cb_title, cb_type, cb_report, cb_hit, cb_reg_date"
    		+ "	FROM community_board"
    		+ " ORDER BY cb_reg_date DESC")
    public List<BoardVO> getAllCommutnity();
    
    @Select("SELECT ab_num, mem_num, ab_title, ab_type, ab_report, ab_hit, ab_reg_date"
    		+ "	FROM assignment_board"
    		+ "	ORDER BY ab_reg_date DESC")
    public List<AssignVO> getAllAssignment();

}
