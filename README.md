# Open-Order-Reports-Using-CDS-IDA
This is an open orders report which uses CDS Consumption view with parameters and has SALV IDA approach for displaying the data

## Tables Used 

* VBAK
* VBAP
* VBPA
* KNA1
* ADRC
* MARC
* MAKT
* VBEP

## Data Flow 

* AMDP class ZCL_OPEN_AMDP has the method which provides data to Table Function Z_BASE_ORDERS ( here VBAK, VBAP, and running sum is calculated )
* From ZSD_BASE_ORDERS our composite view ZSD_OPEN_ORDERS_COMPOS with the parameter ERDAT is querying data ( here all the joins andassociations with other above mentioned
  tables are used 2 associations are local to be used at consumption )
* From composite view , our consumption view ZSD_OPEN_ORDERS_CONSUM is querying data ( no join here )

## ALV display using IDA 

### Selection Screen - 

![image](https://github.com/user-attachments/assets/319a7ee6-6080-4bbe-91bb-8f918b247d5a)

### Output - 

![image](https://github.com/user-attachments/assets/136cab74-1232-4573-ac88-1709844acad6)

### Layout Selection - 

![image](https://github.com/user-attachments/assets/4cd2cf04-0de6-4197-9509-a946ee282ba4)

### Running Sum
![image](https://github.com/user-attachments/assets/c23b4e9e-53e3-4031-8ba9-c67f8c7e1475)
