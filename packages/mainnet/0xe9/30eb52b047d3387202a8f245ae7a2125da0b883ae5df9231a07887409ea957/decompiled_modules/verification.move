module 0xe930eb52b047d3387202a8f245ae7a2125da0b883ae5df9231a07887409ea957::verification {
    struct Verification has key {
        id: 0x2::object::UID,
        verification_id: 0x1::string::String,
        subject: 0x1::string::String,
        method: u64,
        level: u64,
        issuer: 0x1::string::String,
        commitment: 0x1::string::String,
        issued_at: u64,
        expires_at: u64,
        claim_state: u64,
    }

    struct Minted has copy, drop {
        verification: address,
    }

    public fun advance(arg0: &mut Verification, arg1: u64) {
        assert!(arg0.claim_state < 3, 7);
        assert!(arg1 > arg0.claim_state && arg1 < 3, 9);
        arg0.claim_state = arg1;
    }

    public fun claim_state(arg0: &Verification) : u64 {
        arg0.claim_state
    }

    public fun commitment(arg0: &Verification) : &0x1::string::String {
        &arg0.commitment
    }

    public fun create_verification(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Verification{
            id              : 0x2::object::new(arg7),
            verification_id : arg0,
            subject         : arg1,
            method          : arg2,
            level           : arg3,
            issuer          : arg4,
            commitment      : arg5,
            issued_at       : 0x2::clock::timestamp_ms(arg6),
            expires_at      : 0,
            claim_state     : 0,
        };
        let v1 = Minted{verification: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<Minted>(v1);
        0x2::transfer::transfer<Verification>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun expires_at(arg0: &Verification) : u64 {
        arg0.expires_at
    }

    public fun issued_at(arg0: &Verification) : u64 {
        arg0.issued_at
    }

    public fun issuer(arg0: &Verification) : &0x1::string::String {
        &arg0.issuer
    }

    public fun level(arg0: &Verification) : u64 {
        arg0.level
    }

    public fun method(arg0: &Verification) : u64 {
        arg0.method
    }

    public fun subject(arg0: &Verification) : &0x1::string::String {
        &arg0.subject
    }

    public fun verification_id(arg0: &Verification) : &0x1::string::String {
        &arg0.verification_id
    }

    // decompiled from Move bytecode v7
}

