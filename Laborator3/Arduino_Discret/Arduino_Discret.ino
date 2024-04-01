float c[3]={0,0,0}; 
float e[3]={0,0,0}; 
float in() 
{ 
union u_tag 
{ 
byte b[4]; 
float fvalue; 
} in; 
in.fvalue=0; 
for (int i=0 ; i<4 ; i++) 
{ 
while (!Serial.available()); 
in.b[i]=Serial.read(); 
} 
return in.fvalue; 
} 
void out(float c) 
{ 
union u_tag 
{ 
byte b[4]; 
float fvalue; 
}out; 
out.fvalue=c; 
Serial.write(out.b[0]); 
Serial.write(out.b[1]); 
Serial.write(out.b[2]); 
Serial.write(out.b[3]); 
} 
void setup() 
{ 
Serial.begin(9600); 
delay(1000); 
out(0); 
} 
void loop() 
{ 
e[0]=in(); 
//insert below the calculated discrete control function 
double b0 = 1.0046;
double b1 = -0.9961;
c[0] = c[1] + b0*e[0] + b1*e[1];
out(c[0]); 
for(int i=2;i>0;i--) 
{ 
c[i]=c[i-1]; 
e[i]=e[i-1]; 
} 
}