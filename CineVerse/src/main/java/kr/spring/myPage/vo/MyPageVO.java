package kr.spring.myPage.vo;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

import kr.spring.movie.vo.MovieBookingVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"photo"})
public class MyPageVO {
	private Long mem_num;
	@Pattern(regexp = "^[0-9a-zA-Z]{4,12}$")
	private String mem_id;
	private String mem_nickName;
	private int mem_auth;
	private String auto;
	private String au_id;

	@NotBlank
	private String mem_name;
	
	@Pattern(regexp = "^[0-9a-zA-Z]{4,12}$")
	private String mem_passwd;

	@NotBlank
	private String mem_phone;

	@NotBlank
	private String mem_email;
	private Date mem_reg_date;
	private Date mem_modify_date;
	private String social_kakao;
	
	//사진
	private byte[] photo;
	private String photo_name;

	private int mem_rank;
	private int mem_membership;


	private int coupon_cnt;	// 쿠폰 개수를 지정하는 이름

	private long mc_num;		// 회원의 쿠폰 번호
	private long coupon_use;		// 회원 쿠폰 사용 여부 1:미사용, 2:사용, 3:만기
	private long coupon_num;	// 쿠폰의 번호

	private String coupon_name;		// 쿠폰 이름
	private String coupon_content;	// 쿠폰 내용
	private int coupon_type;		// 1:금액 할인 , 2:퍼센트 할
	private int coupon_sale;		// 할인 금액
	private int coupon_where;		// 어디서 사용 가능한지 1:영화 2:벌스샵
	private Date coupon_regdate;	// 쿠폰 발급일자

	//board
	private String cb_title;
	private String cb_content;
	private String cb_type;	//카테고리
	private Date cb_reg_date;
	private Date cb_modify_date;
	private int fav_cnt;			//좋아요 개수


	private Date coupon_enddate;	// 쿠폰 만료일자

	// point vo
	private Long ph_num;
	private Long ph_point;
	private Date ph_date;
	private String ph_payment;
	private int ph_type;
	private int point;
	
	private String user_mb_num;
	private Long mb_num;
	private Date mb_date;
	private Long mb_price;
	private Long mt_num;
	private Long m_code;
	private String m_name;
	private String th_name;
	private String c_branch;
	private String seat_row;
	private int seat_column;
	private int mt_start;
	private int mt_end;
	private Date mt_date;
	private int md_type;
	private Long mem_coupon_use;

	// 비밀번호 변경시 현재 비밀번호를 저장하는 용도로 사용
	@Pattern(regexp = "^[0-9a-zA-Z]{4,12}$")
	private String now_passwd;	// 컬럼은 없지만 필요에 의해 생성해줌

	// 비밀번호 변경에만 조건 체크
	@Pattern(regexp="^[A-Za-z0-9]+$")
	private String captcha_chars;

	//비밀번호 일치 여부 체크
	public boolean ischeckedPassword(String userPasswd) {
		if(mem_auth > 1 && mem_passwd.equals(userPasswd)) {
			return true;
		}
		return false;
	}

	// 이미지 BLOB 처리
	// (주의) 폼에서 파일 업로드 파라미터 네임은 반드시 upload로 지정해야 한다
	public void setUpload(MultipartFile upload) throws IOException {
		// MultipartFile -> byte []
		setPhoto(upload.getBytes());

		//파일 이름
		setPhoto_name(upload.getOriginalFilename());
	}
}
