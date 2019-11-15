SELECT
  all_staff_report.id_nbr,
  TRIM(lower(all_staff_report.first_name)) as first_name,
  TRIM(lower(all_staff_report.last_name)) as last_name,
  SAFE_CAST(all_staff_report.file_number as INT64) as file_number,
  TRIM(all_staff_report.gndr) as gender,
  TRIM(all_staff_report.raceethn) as race_ethnicity_cd,
  race_ethnicity.description as race_ethnicity_desc,
  all_staff_report.birth_year,
  SAFE_CAST(all_staff_report.high_degree as INT64) as high_degree_cd,
  TRIM(highest_degree.description) as high_degree_desc,
  SAFE_CAST(REGEXP_EXTRACT(all_staff_report.year_session, r"^[0-9]{4}") AS INT64) as school_year,
  all_staff_report.cntrct_days as contract_days,
  all_staff_report.local_exp,
  all_staff_report.total_exp,
  CAST(REGEXP_REPLACE(REGEXP_REPLACE(all_staff_report.tot_salary, r"^[$]",""), r",","") AS FLOAT64) as salary,
  CAST(REGEXP_REPLACE(REGEXP_REPLACE(all_staff_report.tot_fringe, r"^[$]",""), r",","") AS FLOAT64) as benefits,
  SAFE_CAST(all_staff_report.staff_cat as INT64) as staff_category_cd,
  TRIM(staff_cat.description) as staff_category_desc,
  LPAD(CAST(all_staff_report.hire_agncy_typ AS STRING), 2, "0") as hire_agency_type_cd,
  hire_agency_type.description as hire_agency_type_desc,
  all_staff_report.hire_agncy_cd as hire_agency_cd,
  LPAD(CAST(all_staff_report.work_agncy_typ AS STRING), 2, "0") as work_agency_type_cd,
  work_agency_type.description as work_agency_type_desc,
  all_staff_report.work_agncy_cd as work_agency_cd,
  TRIM(all_staff_report.school_cd) as school_cd,
  position.position_type as position_type_cd,
  pos_type.description as position_type_desc,
  all_staff_report.position_cd,
  position.position_description,
  all_staff_report.assgn_area_cd as assignment_area_cd,
  assignment_area.assignment_area_description,
  TRIM(all_staff_report.low_grd) as low_grade,
  TRIM(all_staff_report.high_grd) as high_grade,
  all_staff_report.lg_sort_cd,
  all_staff_report.hg_sort_cd,
  all_staff_report.bilingual,
  all_staff_report.assgn_fte,
  TRIM(all_staff_report.work_location_name) as work_location_name,
  TRIM(all_staff_report.school_name) as school_name,
  TRIM(all_staff_report.grd_level) as grade_level,
  SAFE_CAST(TRIM(all_staff_report.cesa_number) as INT64) as cesa_num,
  all_staff_report.cnty_nbr as county_number,
  TRIM(all_staff_report.cnty_name) as county_name,
  TRIM(all_staff_report.school_mailing_address1) as school_mailing_address1,
  TRIM(all_staff_report.school_mailing_address2) as school_mailing_address2,
  TRIM(all_staff_report.mail_city) as mail_city,
  TRIM(all_staff_report.mail_st) as mail_st,
  TRIM(all_staff_report.mail_zip_cd) as mail_zip_cd,
  TRIM(all_staff_report.school_shipping_address1) as school_shipping_address1,
  TRIM(all_staff_report.school_shipping_address2) as school_shipping_address2,
  TRIM(all_staff_report.mail_city) as ship_city,
  TRIM(all_staff_report.mail_st) as ship_st,
  TRIM(all_staff_report.mail_zip_cd) as ship_zip_cd,
  TRIM(all_staff_report.phone) as phone,
  TRIM(all_staff_report.admin_name) as admin_name,
  TRIM(all_staff_report.former_last_nm) as former_last_name,
  TRIM(all_staff_report.lt_sub) as long_term_sub,
  TRIM(all_staff_report.sub_cntrctd) as sub_contracted
FROM
  `wi-dpi-010.2015.2015_raw_data` all_staff_report 
  LEFT JOIN `wi-dpi-010.2015.2015_positions` position 
   ON all_staff_report.position_cd = position.code
  LEFT JOIN `wi-dpi-010.2015.2015_assignment_area` assignment_area
   ON all_staff_report.assgn_area_cd = CAST(assignment_area.code as INT64)
  LEFT JOIN `wi-dpi-010.2015.2015_highest_educational_degree` highest_degree
   ON SAFE_CAST(all_staff_report.high_degree as INT64) = highest_degree.code
  LEFT JOIN `wi-dpi-010.2015.2015_staff_category` staff_cat
   ON SAFE_CAST(all_staff_report.staff_cat as INT64) = staff_cat.code
  LEFT JOIN `wi-dpi-010.2015.2015_position_type` pos_type
   ON position.position_type = pos_type.code
  LEFT JOIN `wi-dpi-010.2015.2015_agency_type` hire_agency_type
   ON LPAD(CAST(all_staff_report.hire_agncy_typ AS STRING), 2, "0") = hire_agency_type.code
  LEFT JOIN `wi-dpi-010.2015.2015_agency_type` work_agency_type
   ON LPAD(CAST(all_staff_report.work_agncy_typ AS STRING), 2, "0") = work_agency_type.code
  LEFT JOIN `wi-dpi-010.2015.2015_race` race_ethnicity
   ON TRIM(all_staff_report.raceethn) = race_ethnicity.code