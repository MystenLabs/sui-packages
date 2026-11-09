module 0x38ac8750c7a00c9b4fba9a5bd86320ec67590da579a859b85eb69f5571b4f81b::share {
    struct Grant has key {
        id: 0x2::object::UID,
        owner: address,
        consultant: address,
        expires_ms: u64,
        revoked: bool,
    }

    public fun create_grant(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Grant{
            id         : 0x2::object::new(arg2),
            owner      : 0x2::tx_context::sender(arg2),
            consultant : arg0,
            expires_ms : arg1,
            revoked    : false,
        };
        0x2::transfer::share_object<Grant>(v0);
    }

    fun is_prefix(arg0: vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun revoke(arg0: &mut Grant, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        arg0.revoked = true;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Grant, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(is_prefix(0x2::object::uid_to_bytes(&arg1.id), &arg0), 1);
        assert!(!arg1.revoked, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.expires_ms, 1);
        assert!(0x2::tx_context::sender(arg3) == arg1.consultant || 0x2::tx_context::sender(arg3) == arg1.owner, 1);
    }

    // decompiled from Move bytecode v7
}

