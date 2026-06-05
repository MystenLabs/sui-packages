module 0x998a23f76e7dbaa6b0d18df95873166e8aab3d7eead1d30f8b83eb71b0110ced::credential {
    struct Credential has store, key {
        id: 0x2::object::UID,
        issuer: address,
        institution_name: 0x1::string::String,
        recipient_name: 0x1::string::String,
        recipient_email: 0x1::string::String,
        degree: 0x1::string::String,
        department: 0x1::string::String,
        graduation_year: 0x1::string::String,
        grade: 0x1::string::String,
        blob_id: 0x1::string::String,
        issued_at: u64,
        is_active: bool,
    }

    struct InstitutionCap has store, key {
        id: 0x2::object::UID,
        institution_name: 0x1::string::String,
        registered_at: u64,
    }

    struct CredentialIssued has copy, drop {
        credential_id: 0x2::object::ID,
        issuer: address,
        institution_name: 0x1::string::String,
        recipient_name: 0x1::string::String,
        degree: 0x1::string::String,
        blob_id: 0x1::string::String,
        issued_at: u64,
    }

    struct CredentialRevoked has copy, drop {
        credential_id: 0x2::object::ID,
        issuer: address,
        revoked_at: u64,
    }

    public fun get_blob_id(arg0: &Credential) : 0x1::string::String {
        arg0.blob_id
    }

    public fun get_degree(arg0: &Credential) : 0x1::string::String {
        arg0.degree
    }

    public fun get_department(arg0: &Credential) : 0x1::string::String {
        arg0.department
    }

    public fun get_grade(arg0: &Credential) : 0x1::string::String {
        arg0.grade
    }

    public fun get_institution_name(arg0: &Credential) : 0x1::string::String {
        arg0.institution_name
    }

    public fun get_is_active(arg0: &Credential) : bool {
        arg0.is_active
    }

    public fun get_issued_at(arg0: &Credential) : u64 {
        arg0.issued_at
    }

    public fun get_issuer(arg0: &Credential) : address {
        arg0.issuer
    }

    public fun get_recipient_name(arg0: &Credential) : 0x1::string::String {
        arg0.recipient_name
    }

    public fun get_year(arg0: &Credential) : 0x1::string::String {
        arg0.graduation_year
    }

    public fun issue_credential(arg0: &InstitutionCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = Credential{
            id               : 0x2::object::new(arg9),
            issuer           : 0x2::tx_context::sender(arg9),
            institution_name : arg0.institution_name,
            recipient_name   : arg1,
            recipient_email  : arg2,
            degree           : arg3,
            department       : arg4,
            graduation_year  : arg5,
            grade            : arg6,
            blob_id          : arg7,
            issued_at        : v0,
            is_active        : true,
        };
        let v2 = CredentialIssued{
            credential_id    : 0x2::object::id<Credential>(&v1),
            issuer           : 0x2::tx_context::sender(arg9),
            institution_name : arg0.institution_name,
            recipient_name   : arg1,
            degree           : arg3,
            blob_id          : arg7,
            issued_at        : v0,
        };
        0x2::event::emit<CredentialIssued>(v2);
        0x2::transfer::share_object<Credential>(v1);
    }

    public fun register_institution(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : InstitutionCap {
        InstitutionCap{
            id               : 0x2::object::new(arg2),
            institution_name : arg0,
            registered_at    : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun revoke_credential(arg0: &mut Credential, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.issuer == 0x2::tx_context::sender(arg2), 0);
        arg0.is_active = false;
        let v0 = CredentialRevoked{
            credential_id : 0x2::object::id<Credential>(arg0),
            issuer        : 0x2::tx_context::sender(arg2),
            revoked_at    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CredentialRevoked>(v0);
    }

    // decompiled from Move bytecode v7
}

