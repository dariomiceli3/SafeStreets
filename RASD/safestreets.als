sig FiscalCode {}
sig Matricola {}
sig Email {}
sig Password {}

sig Registration {
    email: one Email,
    password: one Password
}

abstract sig User {
    registration: one Registration
}

sig Citizen extends User {
    fiscalCode: one FiscalCode
}

sig Authority extends User {
    matricola: one Matricola
}

sig Location {
  latitude: one Int, 
    longitude: one Int
}
--{latitude >= -90 and latitude <= 90 and longitude >= -180 and longitude <= 180 }

sig Date {}
sig Time {}
sig License {}
sig Type {} 

sig Violation {
    location: one Location,
    date: one Date,
    time: one Time,
    license: one License,
    type: one Type

}

--All fiscalcode have to be associated to Citizen 
fact FiscalCodeCitizen {
    all fc: FiscalCode | some c: Citizen | fc in c.fiscalCode 
}

--All matricola have to be associated to Authority 
fact MatricolaAuthority {
    all m: Matricola | some a: Authority | m in a.matricola 
}

-- All registration have to be associated to User
fact RegistrationUser {
  all r: Registration | some u: User | r in u.registration
}

--All email have to be associated to a User Registration
fact EmailRegistration {
    all e : Email | some u: User | e in u.registration.email
}

--All password have to be associated to a User Registration
fact PassRegistration {
    all p : Password | some u: User| p in u.registration.password
}

--Every User has different email
fact NoSameEmail {
    no disj u1, u2 :User | u1.registration.email = u2.registration.email
}

--Every Citizen has different FiscalCode
fact NoSameFiscalCode {
    no disj c1, c2 : Citizen | c1.fiscalCode = c2.fiscalCode
    }

--Every Authority has different Matricola
fact NoSameAuthority {
    no disj a1, a2 : Authority | a1.matricola = a2.matricola
    }


--All Location have to be associated to a Violation 
fact LocationViolation {
    all l: Location | some v: Violation | l in v.location
}

--All time have to be associated to a Violation 
fact TimeViolation {
    all t: Time | some v: Violation | t in v.time
}

--All Date have to be associated to a Violation 
fact DateViolation {
    all d: Date | some v: Violation | d in v.date
}

--All LicensePlate have to be associated to a Violation 
fact LicenseViolation {
    all lp: License | some v: Violation | lp in v.license
}

--All Type have to be associated to a Violation 
fact TypeViolation {
    all t: Type | some v: Violation | t in v.type
}

--All latitude have to be associated to a Position
--fact 

pred show {}
run show for 5