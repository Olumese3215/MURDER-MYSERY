--STEP 1; I Querried the Police department database to show the crime_scene report, Using the following syntax;
SELECT *
FROM crime_scene_report;
--The table of the above querry returned a result set with date,type,description and city.


--STEP 2;I filtered the table with the detective brief identified was a murder that occured on Jan 15,2018 in SQL city.
SELECT *
FROM crime_scene_report
WHERE type ="murder" AND date=20180115 AND city="SQL City";
/* TheFrom the above querry result set, the description column attest that the security footage shows that there are 2 witnesses.
   The first witness lives at the Last house on "Northwestern Dr" and the second witness,named Annabel, lives somewhere
   on "Franklin Ave".*/
   
 
/* STEP 3; The address obtained from the result set of step2 will be used to find the ID and NAME of the first witness.This
            will be done by querrying the Person's table and filtering it with the address "Nortwestern Dr".The first witness
            lives at the last house, so I will order the witness's address number  in descending order and Limit it by 1 so that I
            can see the last person living in the last house of Northwestern Dr Street.*/
 SELECT Id,name,address_street_name
 FROM person 
 WHERE address_street_name="Northwestern Dr"
 ORDER BY address_number DESC
 LIMIT 1;
 /*Upon the above querry from the result set obtained,the Name of the person living in the last house
                         is Morty Schapiro with id 14887.*/    
 
 
 /* STEP 4; The Second witness ID number will be retrieved using their name and address. This will be done by querrying
            Person Table and filtering it with the witness's name and address;"Annabel and Franklin Ave".*/
SELECT name,id,address_street_name
FROM person
WHERE name LIKE "%Annabel%" AND address_street_name="Franklin Ave";
/* Upon the above querry, from the the result set obtained , the name of the second witness is 
   Annabel Miller with an ID of 16371.*/
   
/* STEP 5;After obtaining the ID of the two witness,I carefully examined the  database schema, and the schema table showed
   that the Person and interview table has foreign and primary key. The person table has the primary key(Id) while the
   Interview table had the foreign key(Person Id).These keys will be utilized to join both tables together from which relevant 
   information will be obtained.*/
   SELECT person.name,person.id,interview.transcript
   FROM person
   JOIN interview
   ON person.id=interview.person_id
   WHERE person.id=14887
   OR person.id=16371;
/* The FIRST WITNESS( id=14887) transcript reads that "I heard a gunshot and then saw a man run out.He had a "Get Fit Now"bag.
   The membership number on the bag started with "48Z".only gold members have those bags.The man got into the car with a plate that 
   included "H42W".*/
 /* THE SECOND WITNESS (Id=16371) transcript read "I saw the murder happen, and i recognised the killer from my gym when I was
    working on January 9th.*/
    
    
  /* STEP6; The witness transcript from the interview tells that the killer is a man and as well a gym member whose membership number
            started with "48Z".To obtain the membership Id of who committed the crime, I Wrote the querry to check the
            get_fit_now_member table and filtered based on what the first witness mentioned( membership starting with 48Z) on a bag 
            which was identified with Gold Membership status.*/
  SELECT *
  FROM get_fit_now_member
  where id like "48Z%" and membership_status="gold";
  /* The querry result set shows 2 member with name( Joe Germuska,Jeremy Bowers),Person Id(28819,67318),Id(48Z7A,48Z55).*/
  
  
  /*STEP7; According to the second witness- Annable Miller( she mentioned she recognised the killer when she was working out
           on January 9th.Given this information, I will write a querry to check the get_fit_now_check_in table and filter it
           with the 2membership id from the first witness transcript(48Z7A,48Z55).*/
 SELECT *
 FROM get_fit_now_check_in
 WHERE check_in_date=20180109 AND membership_id IN ("48Z7A","48Z55");
 /* The querry results shows that the two members with membership ID (48Z7A,48Z55) bOth checked in on 
    the 9th of january,2018.*/
    
 /*STEP8; From the findings one can tell that the crime was committed by either Joe Germuska or Jeremy Bowers as they
          both checked in on the 9th of january.However to identify the main suspect who committed the crime,i will 
          utilise the report of our first witness who attested that the man got into a car with a plate number that included
          "H42W".Hence, to identify the main suspect between the two men who committed the crime,i used the schema diagram to join 
          the person table and driver license table as they both have primary and foreign key id and I filtered it with their person id
          to find out whose car was registered with "H42W".*/
SELECT person.name,drivers_license.plate_number,drivers_license.gender,person.address_number,person.address_street_name,person.ssn
FROM person
JOIN drivers_license
ON drivers_license.id=person.license_id
WHERE person.id IN (67318,28819);
/* Upon the above querry,it was discovered that Jeremy Bowers has a car with license number H42W as mentioned
   by his first witness and his gender reveal that he is male and reside at 530,Washington PI,Apt 3A.*/
   
--SUMMARY; It is apparent that JEREMY BOWERS committed the murder as my findings revealed.
