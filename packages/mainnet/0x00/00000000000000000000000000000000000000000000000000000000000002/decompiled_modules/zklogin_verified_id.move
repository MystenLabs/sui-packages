module 0x2::zklogin_verified_id {
    struct VerifiedID has key {
        id: 0x2::object::UID,
        owner: address,
        key_claim_name: 0x1::string::String,
        key_claim_value: 0x1::string::String,
        issuer: 0x1::string::String,
        audience: 0x1::string::String,
    }

    public fun delete(arg0: VerifiedID) {
        let VerifiedID {
            id              : v0,
            owner           : _,
            key_claim_name  : _,
            key_claim_value : _,
            issuer          : _,
            audience        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun audience(arg0: &VerifiedID) : &0x1::string::String {
        &arg0.audience
    }

    public fun check_zklogin_id(arg0: address, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String, arg5: u256) : bool {
        abort 0
    }

    native fun check_zklogin_id_internal(arg0: address, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: u256) : bool;
    public fun issuer(arg0: &VerifiedID) : &0x1::string::String {
        &arg0.issuer
    }

    public fun key_claim_name(arg0: &VerifiedID) : &0x1::string::String {
        &arg0.key_claim_name
    }

    public fun key_claim_value(arg0: &VerifiedID) : &0x1::string::String {
        &arg0.key_claim_value
    }

    public fun owner(arg0: &VerifiedID) : address {
        arg0.owner
    }

    public fun verify_zklogin_id(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

