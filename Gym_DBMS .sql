

create table member (
    m_id number primary key,
    f_name varchar2(50),
    fa_name varchar2(50),
    dob date,
    phone varchar2(15),
    join_date date,
    status varchar2(20)
);


select *from member
create table trainers (
    t_id number primary key,
    t_name varchar2(50),    
    t_access varchar2(50),
    t_spec varchar2(100),
    t_salary number
);

insert into  trainers values(1,'shafaq','6:00 - 8:00 PM','strienght trainer',19000,1);
insert into  trainers values(2,'khalid','5:00 - 7:00 AM','strienght trainer',17000,2);

select *from staff
create table staff(
    s_id number primary key,
    s_name varchar2(50),
    s_add varchar2(100),
    s_phone varchar2(15),
    s_email varchar2(50),
    s_salary number,
    s_job varchar2(50)
);
insert into  staff values(1,'karim','kandahar','0776505774','karimkhan@gmail.com',19000,'Manager');
insert into  staff values(2,'rahim','helmand','0776504474','rahimkhan@gmail.com',9000,'worker');



create table equipment (
    e_id number primary key,
    e_name varchar2(50),
    e_quantity varchar2(50),
    e_function varchar2(100)
);

select *from equipment

create table package (
    p_id number primary key,
    p_name varchar2(50),
    p_duration varchar2(50),
    p_status varchar2(20),
    p_comment varchar2(50)
);
insert into  package values(1,'Basic','1 Mounth','Active','beginner package',1);
insert into  package values(2,'Basic','1 Mounth','Active','beginner package',2);



create table box (
    b_id number primary key,
    b_status varchar2(20)
);


create table attendance (
    a_id number primary key,
    a_date date,
    a_status varchar2(20)
);


create table payment (
    pa_id number primary key,
    m_idf number,
    pa_amount number,
    pa_date date,
    pa_discount number,
    pa_endate date,
    foreign key (m_idf) references member(m_id)
);

alter table payment modify pa_amount number(10, 2);
select *from member

-- Sequence
create sequence seq_member_id start with 1 increment by 1;

-- Member and Package (N:1)
alter table member add pak_id number;
alter table member add constraint fk_member_package foreign key (pak_id) references package(p_id);

-- Member and Trainers (N:1)
alter table member add t_idf number;
alter table member add constraint fk_member_trainers foreign key (t_idf) references trainers(t_id);

-- Member and Attendance (1:1)
alter table attendance add m_idf number unique;
alter table attendance add constraint fk_attendance_member foreign key (m_idf) references member(m_id);

-- Member and Payment (1:1)
alter table payment add constraint fk_payment_member unique (m_idf);

-- Member and Equipment (N:M)
create table member_equipment (
    m_idf number,
    e_idf number,
    primary key (m_idf, e_idf),
    foreign key (m_idf) references member(m_id),
    foreign key (e_idf) references equipment(e_id)
);

-- Member and Box (1:1)
alter table box add m_idf number unique;
alter table box add constraint fk_box_member foreign key (m_idf) references member(m_id);

-- Member and Staff (N:1)
alter table member add s_idf number;
alter table member add constraint fk_member_staff foreign key (s_idf) references staff(s_id);

-- Trainers and Package (1:N)
alter table package add t_idf number;
alter table package add constraint fk_package_trainers foreign key (t_idf) references trainers(t_id);

-- Trainers and Staff (N:1)
alter table trainers add s_idf number;
alter table trainers add constraint fk_trainers_staff foreign key (s_idf) references staff(s_id);

-- Staff and Payment (1:N)
alter table payment add s_idf number;
alter table payment add constraint fk_payment_staff foreign key (s_idf) references staff(s_id);

-- Staff and Equipment (1:N)
alter table equipment add s_idf number;
alter table equipment add constraint fk_equipment_staff foreign key (s_idf) references staff(s_id);

-- Staff and Box (1:N)
alter table box add s_idf number;
alter table box add constraint fk_box_staff foreign key (s_idf) references staff(s_id);

-- Staff and Attendance (1:1)
alter table attendance modify s_idf number;
alter table attendance modify constraint fk_attendance_staff foreign key (s_idf) references staff(s_id);
commit
-- Package and Equipment (N:M)
create table package_equipment (
    p_idf number,
    e_idf number,
    primary key (p_idf, e_idf),
    foreign key (p_idf) references package(p_id),
    foreign key (e_idf) references equipment(e_id)
);





insert into member (m_id, f_name, fa_name, dob, phone, join_date, status,pak_id,t_idf,s_idf)  
values (2, 'khaiber', 'zafar', to_date('1999-03-20', 'YYYY-MM-DD'), '0791224577', to_date('2024-2-01', 'YYYY-MM-DD'), 'Active',1,1,2);  

insert into member (m_id, f_name, fa_name, dob, phone, join_date, status,pak_id,t_idf,s_idf) 
values (3, 'shahid', 'sadiq', to_date('2001-05-20', 'YYYY-MM-DD'), '0791666664', to_date('2024-1-01', 'YYYY-MM-DD'), 'Active',2,2,1);  

insert into member (m_id, f_name, fa_name, dob, phone, join_date, status,pak_id,t_idf,s_idf)   
values (4, 'rafiq', 'sohail', to_date('2003-02-23', 'YYYY-MM-DD'), '0797684563', to_date('2023-12-01', 'YYYY-MM-DD'), 'Active',2,1,1);  

insert into member (m_id, f_name, fa_name, dob, phone, join_date, status,pak_id,t_idf,s_idf) 
values (5, 'samim', 'dawlat', to_date('1989-05-20', 'YYYY-MM-DD'), '0791234565', to_date('2023-05-01', 'YYYY-MM-DD'), 'Active',2,2,2);  

-- Insert Data into Trainers Table
insert into trainers (t_id, t_name, t_access, t_spec, t_salary)  
values (3, 'Ali', 'Full', 'Weight Training', 18000);  

-- Insert Data into Staff Table
insert into staff (s_id, s_name, s_add, s_phone, s_email, s_salary, s_job)  
values (3, 'qasim', 'Kabul, Afghanistan', '0789876543', 'qasim@gmail.com', 5000, 'Receptionist');  

-- Insert Data into Equipment Table
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (2, 'rowing machine', '13', 'Cardio Workouts',2);

insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (3, 'Stepper', '14', 'Cardio Workouts',1);  
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (4, 'flat Bench', '8', 'Racks',3);  
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (5, 'Power rack', '10', 'Racks',1);  
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (6, 'Dommbels', '15', 'Free Wieght',4);  
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (7, 'Barbells', '20', 'Free Wieght',1);  
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (8, 'Ressistance Bands', '10', 'Ressistance training',4);  
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (9, 'Yoga mat', '11', 'Floor tools',3);  
insert into equipment (e_id, e_name, e_quantity, e_function,s_idf)  
values (10, 'Ab wheel', '10', 'floor tools',2);  
select *from equipment


-- Insert Data into Package Table
insert into package (p_id, p_name, p_duration, p_status, p_comment)  
values (3, 'Gold Plan', '6 Months', 'Active', 'Premium Package');  

-- Insert Data into Box Table
select *from box
insert into box (b_id, b_status,m_idf,s_idf)  
values (1, 'Available',1,2);  
insert into box (b_id, b_status,m_idf,s_idf)  
values (2, 'Available'2,1); 
insert into box (b_id, b_status,m_idf,s_idf)  
values (3, 'Available',3,4); 
insert into box (b_id, b_status,m_idf,s_idf)  
values (4, 'Available',5,2); 
insert into box (b_id, b_status,m_idf,s_idf)  
values (5, 'Available',1,3); 
insert into box (b_id, b_status,m_idf,s_idf)  
values (6, 'Available',2,2); 
-- Insert Data into Attendance Table
insert into attendance (a_id, a_date, a_status,m_idf,s_idf)  
values (2, to_date('2024-02-20', 'YYYY-MM-DD'), 'Present',2,3);  
 
commit
select *from member
select *from payment
-- Insert Data into Payment Table
insert into payment (pa_id, m_idf, pa_amount, pa_date, pa_discount, pa_endate,s_idf)  
values (2, 2, 1500.00, to_date('2023-12-21', 'YYYY-MM-DD'), 50.00, to_date('2024-06-21', 'YYYY-MM-DD'),3);
insert into payment (pa_id, m_idf, pa_amount, pa_date, pa_discount, pa_endate,s_idf)  
values (3, 3, 1500.00, to_date('2023-12-21', 'YYYY-MM-DD'), 70.00, to_date('2024-05-20', 'YYYY-MM-DD'),2);
insert into payment (pa_id, m_idf, pa_amount, pa_date, pa_discount, pa_endate,s_idf)  
values (4, 4, 1500.00, to_date('2023-12-21', 'YYYY-MM-DD'), 60.00, to_date('2024-09-11', 'YYYY-MM-DD'),2);
insert into payment (pa_id, m_idf, pa_amount, pa_date, pa_discount, pa_endate,s_idf)  
values (5, 5, 1500.00, to_date('2023-12-21', 'YYYY-MM-DD'), 50.00, to_date('2024-12-02', 'YYYY-MM-DD'),3);

-- INSERT DATA THROUGH STORED PROCEDURE

using stored procedure
select *from member
create or replace procedure addnewmember (  
    p_f_name in varchar2,  
    p_fa_name in varchar2,  
    p_dob in date,  
    p_phone in varchar2,  
    p_join_date in date,  
    p_status in varchar2 , 
    p_pak in number,
    t_idf in number,
    s_idf in number
) as  
begin  
    insert into member (m_id, f_name, fa_name, dob, phone, join_date, status, pak_id,t_idf,s_idf)  
    values (seq_member_id.nextval, p_f_name, p_fa_name, p_dob, p_phone, p_join_date, p_status,p_pak ,t_idf,s_idf);  
end;  

-- Execute Procedure
exec addnewmember('Omar', 'Khan', to_date('2000-01-15', 'YYYY-MM-DD'), '0701234544', to_date('2023-11-10', 'YYYY-MM-DD'), 'Inactive',1,2,3);


--Using Sequence Value

insert into member (m_id, f_name, fa_name, dob, phone, join_date, status)  
values (seq_member_id.nextval, 'Sara', 'Ahmadi', to_date('1998-07-07', 'YYYY-MM-DD'), '0798889990', to_date('2023-10-01', 'YYYY-MM-DD'), 'Active');

-- UPDATE & DELETE DATA THROUGH STORED PROCEDURE

update member status

create or replace procedure updatememberstatus (  
    p_m_id in number,  
    p_new_status in varchar2  
) as  
begin  
    update member  
    set status = p_new_status  
    where m_id = p_m_id;  
end;  

-- Execute Update Procedure
exec updatememberstatus(1, 'Inactive');
select *from member

--Delete a Member Record

create or replace procedure deletemember (  
    p_m_id in number  
) as  
begin  
    delete from member where m_id = p_m_id;  
end;  

--problem in this part 
exec deletemember(2);


-- INSERT, UPDATE, DELETE DATA THROUGH VIEW
--Insert Data through View

create or replace view activemembers as  
select m_id, f_name, status from member where status = 'Active';  

insert into activemembers (m_id, f_name, status)  
values (seq_member_id.nextval, 'Zahra', 'Active');

--Update Data through View

update activemembers  
set f_name = 'zabih'  
where m_id = 3;


-- RETRIEVE DATA USING FUNCTIONS
--Scalar Function

create or replace function getmembercount return number as  
    member_count number;  
begin  
    select count(*) into member_count from member;  
    return member_count;  
end;  
-- Call Function
select getmembercount() from dual;

--TRIGGER
--After Insert Trigger

create or replace trigger afterpaymentinsert  
after insert on payment  
for each row  
begin  
    dbms_output.put_line('Payment Added: ' || :new.pa_amount || ' for Member ID: ' || :new.m_idf);  
end;  

-- Test Trigger with Insert
insert into payment (pa_id, m_idf, pa_amount, pa_date, pa_discount, pa_endate,s_idf)  
values (6, 21, 2000.00, to_date('2023-12-21', 'YYYY-MM-DD'), 100.00, to_date('2024-06-21', 'YYYY-MM-DD'),1);
select *from payment


-- Retrieve Active Members
select * from activemembers;  

-- Get Total Payments by Members
select m_idf, sum(pa_amount) as totalpaid  
from payment  
group by m_idf;

--Get Total Payments
select sum (pa_amount) as totalpaid from payment



-- Create a View & Alter View

create view activemembers as
select m_id, f_name, status from member where status = 'Active';







-- Index on Member

create index idx_member_phone on member (phone);
select *from member

create index idx_payment_amount on payment (pa_amount);


-- Create Functions  & Alter Functions

create or replace function calculateage (p_dob date) return number as
begin
    return trunc(months_between(sysdate, p_dob) / 12);
end;

select calculateage(to_date('2002-01-15', 'YYYY-MM-DD')) from dual

create or replace function calculateage (p_dob date, p_format varchar2) return varchar2 as
begin
    if p_format = 'Years' then
        return trunc(months_between(sysdate, p_dob) / 12);
    else
        return trunc(months_between(sysdate, p_dob));
    end if;
end;
commit

select calculateage(to_date('2002-01-15', 'YYYY-MM-DD')) from dual


-- Package

create or replace package membermanagement as
    procedure addnewmember(
        p_f_name in varchar2,
        p_fa_name in varchar2,
        p_dob in date,
        p_phone in varchar2,
        p_join_date in date,
        p_status in varchar2,
        p_pak in number,
        t_idf in number,
        s_idf in number
    );
    procedure updatememberstatus(p_m_id in number, p_new_status in varchar2);
    procedure deletemember(p_m_id in number);
end membermanagement;


create or replace package body membermanagement as
    procedure addnewmember(
        p_f_name in varchar2,
        p_fa_name in varchar2,
        p_dob in date,
        p_phone in varchar2,
        p_join_date in date,
        p_status in varchar2,
        p_pak in number,
        t_idf in number,
        s_idf in number
    ) as
    begin
        insert into member (m_id, f_name, fa_name, dob, phone, join_date, status, pak_id, t_idf, s_idf)
        values (seq_member_id.nextval, p_f_name, p_fa_name, p_dob, p_phone, p_join_date, p_status, p_pak, t_idf, s_idf);
    end;

    procedure updatememberstatus(p_m_id in number, p_new_status in varchar2) as
    begin
        update member
        set status = p_new_status
        where m_id = p_m_id;
    end;

    procedure deletemember(p_m_id in number) as
    begin
        delete from member where m_id = p_m_id;
    end;
end membermanagement;


-- Dynamic SQL
declare v_sql varchar2(4000);
begin
    v_sql := 'SELECT * FROM Member WHERE Status = ''Active''';
    execute immediate v_sql;
end;



-- Cursor

declare  cursor c_members is
        select f_name, status from member;
    v_name member.f_name%type;
    v_status member.status%type;
begin
    open c_members;
    loop
        fetch c_members into v_name, v_status;
        exit when c_members%notfound;
        dbms_output.put_line(v_name || ' is ' || v_status);
    end loop;
    close c_members;
end;


--- Cluster

create cluster memberpaymentcluster (m_id number)
size 1024;

create index idx_memberpaymentcluster on cluster memberpaymentcluster;
create table member cluster memberpaymentcluster (m_id);
create table payment cluster memberpaymentcluster (m_idf);


create table temp_member as 
select *from member;
drop table temp_member

create table temp_payment as 
select *from payment;
drop table temp_payment
-- Analytic Functions

select m_idf, pa_amount, sum(pa_amount) over (partition by m_idf) as totalpaid
from payment;

select *from payment
-- Transaction

begin
    insert into member (m_id, f_name, status)
    values (seq_member_id.nextval, 'TestUser', 'Active');
    savepoint beforedelete;
    delete from member where m_id = 99;
    rollback to beforedelete;
    commit;
end;

-- if Statement


declare p_status varchar2(20) := 'Active';
begin
    if  p_status = 'Active' then
        dbms_output.put_line('Active members exist.');
    else
        dbms_output.put_line('No active members found.');
    end if;
   
end;


set serveroutput on;
select *from member

--Optimizer Hint

select /*+ INDEX(Member IDX_Member_Phone) */ *
from member
where phone = '0791234565';


-- Execution Plan

explain plan for
select * from member where status = 'Active';
select * from table(dbms_xplan.display);

-- Static

insert into member (m_id, f_name, fa_name, dob, phone, join_date, status, pak_id, t_idf, s_idf)
values (seq_member_id.nextval, 'salim', 'rashid', to_date('1990-01-01', 'YYYY-MM-DD'), '1234567890', sysdate, 'Active', 1, 1, 1);

select *from member

commit



-- Merge Join
--Retrieve the list of members and their assigned trainers.

select 
    m.f_name as membername, 
    t.t_name as trainername 
from 
    member m 
    join trainers t on m.t_idf = t.t_id;


-- Hash Join
--List of members with their assigned packages.

SELECT 
    M.F_Name AS MemberName, 
    P.P_Name AS PackageName 
FROM 
    Member M 
    HASH JOIN Package P ON M.pak_id = P.P_ID;
select *from package
-- Nested Loop Join
--Retrieve all payments made by members.

select 
    m.f_name as membername, 
    pa.pa_amount as paymentamount 
from 
    member m 
    join payment pa on m.m_id = pa.m_idf;

--  Inner Join
--Find members who have been assigned a box.

select 
    m.f_name as membername, 
    b.b_status as boxstatus 
from 
    member m 
    inner join box b on m.m_id = b.m_idf;

--Outer Joins
--Left Outer Join
--List all members and their assigned trainers.

select 
    m.f_name as membername, 
    t.t_name as trainername 
from 
    member m 
    left outer join trainers t on m.t_idf = t.t_id;

--Right Outer Join
--List all trainers and the members they are training .

select 
    t.t_name as trainername, 
    m.f_name as membername 
from 
    trainers t 
    right outer join member m on t.t_id = m.t_idf;

--Full Outer Join
--List all members and trainers, whether they are linked or not.

select 
    m.f_name as membername, 
    t.t_name as trainername 
from 
    member m 
    full outer join trainers t on m.t_idf = t.t_id;

--Retrieve equipment assigned to staff.

select 
    e.e_name as equipmentname, 
    s.s_name as staffname 
from 
    equipment e 
    join staff s on e.s_idf = s.s_id;
    
--
--ALTER TABLE payment
--modify CONSTRAINT fk_payment_member
--FOREIGN KEY (m_idf)
--REFERENCES member (m_id)
--ON DELETE SET NULL;
--
--ALTER TABLE attendance
--modify CONSTRAINT fk_attendance_member
--FOREIGN KEY (m_idf)
--REFERENCES member (m_id)
--ON DELETE SET NULL;



--Exception Handling
declare
    v_member_count number;
begin
    select count(*) into v_member_count from member;

    if v_member_count > 0 then
        dbms_output.put_line('Total Members: ' || v_member_count);
    else
        dbms_output.put_line('No members found.');
    end if;
exception
    when others then
        dbms_output.put_line('An error occurred: ' || sqlerrm);
end;




--PL/sql select into

declare
    V_MEMBER_NAME member.F_NAME%type;
begin
    select F_NAME into V_MEMBER_NAME
    from member
    where M_ID = 1;
    
    DBMS_OUTPUT.PUT_LINE('Member Name: ' || V_MEMBER_NAME);
exception
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('No member found with the given ID.');
    when others then
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
end;


