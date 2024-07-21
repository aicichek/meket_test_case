SELECT 
    fl.id AS lesson_id,
    fl.title AS lesson_title,
    fl.description AS lesson_description,
    fl.start_at AS lesson_start,
    fl.end_at AS lesson_end,
    fl.homework_url,
    fl.online_lesson_join_url,
    fl.online_lesson_recording_url,
    ds.name AS stream_name,
    ds.start_at AS stream_start,
    ds.end_at AS stream_end,
    ds.is_open AS stream_is_open,
    dc.title AS course_title,
    dc.icon_url AS course_icon,
    dc.is_auto_course_enroll,
    dc.is_demo_enroll,
    dm.title AS module_title,
    dm.order_in_stream AS module_order,
FROM 
    dwh.fact_lessons fl
INNER JOIN 
    dwh.dim_stream ds ON fl.stream_id = ds.id
INNER JOIN 
    dwh.dim_course dc ON fl.course_id = dc.id
INNER JOIN 
    dwh.dim_module dm ON fl.stream_module_id = dm.id
