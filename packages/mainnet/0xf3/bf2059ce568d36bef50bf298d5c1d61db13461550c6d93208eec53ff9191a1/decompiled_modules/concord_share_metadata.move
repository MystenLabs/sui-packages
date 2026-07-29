module 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata {
    struct ShareRegistrationProof has store, key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    public(friend) fun consume_proof(arg0: ShareRegistrationProof) : (0x2::object::ID, 0x1::string::String, 0x1::string::String) {
        let ShareRegistrationProof {
            id          : v0,
            treasury_id : v1,
            name        : v2,
            symbol      : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    public fun is_valid_name(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 256) {
            return false
        };
        if (*0x1::vector::borrow<u8>(v0, 0) == 32 || *0x1::vector::borrow<u8>(v0, v1 - 1) == 32) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (v3 < 32 || v3 > 126) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun is_valid_symbol(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 32) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = v2 == 0 || v2 == v1 - 1;
            let v5 = if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 >= 65 && v3 <= 90) {
                true
            } else {
                v3 >= 97 && v3 <= 122
            };
            let v6 = if (v3 == 45) {
                true
            } else if (v3 == 46) {
                true
            } else {
                v3 == 95
            };
            let v7 = v4 && v5 || v5 || v6;
            if (!v7) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public(friend) fun mint_proof(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : ShareRegistrationProof {
        assert!(is_valid_name(&arg1) && is_valid_symbol(&arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_share_metadata());
        ShareRegistrationProof{
            id          : 0x2::object::new(arg3),
            treasury_id : arg0,
            name        : arg1,
            symbol      : arg2,
        }
    }

    public fun share_name(arg0: &ShareRegistrationProof) : 0x1::string::String {
        arg0.name
    }

    public fun share_symbol(arg0: &ShareRegistrationProof) : 0x1::string::String {
        arg0.symbol
    }

    public fun treasury_id(arg0: &ShareRegistrationProof) : 0x2::object::ID {
        arg0.treasury_id
    }

    // decompiled from Move bytecode v7
}

