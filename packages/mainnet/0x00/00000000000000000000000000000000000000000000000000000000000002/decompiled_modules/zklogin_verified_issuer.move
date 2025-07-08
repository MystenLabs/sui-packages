module 0x2::zklogin_verified_issuer {
    struct VerifiedIssuer has key {
        id: 0x2::object::UID,
        owner: address,
        issuer: 0x1::string::String,
    }

    public fun delete(arg0: VerifiedIssuer) {
        let VerifiedIssuer {
            id     : v0,
            owner  : _,
            issuer : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun check_zklogin_issuer(arg0: address, arg1: u256, arg2: &0x1::string::String) : bool {
        check_zklogin_issuer_internal(arg0, arg1, 0x1::string::as_bytes(arg2))
    }

    native fun check_zklogin_issuer_internal(arg0: address, arg1: u256, arg2: &vector<u8>) : bool;
    public fun issuer(arg0: &VerifiedIssuer) : &0x1::string::String {
        &arg0.issuer
    }

    public fun owner(arg0: &VerifiedIssuer) : address {
        arg0.owner
    }

    public fun verify_zklogin_issuer(arg0: u256, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(check_zklogin_issuer(v0, arg0, &arg1), 1);
        let v1 = VerifiedIssuer{
            id     : 0x2::object::new(arg2),
            owner  : v0,
            issuer : arg1,
        };
        0x2::transfer::transfer<VerifiedIssuer>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

