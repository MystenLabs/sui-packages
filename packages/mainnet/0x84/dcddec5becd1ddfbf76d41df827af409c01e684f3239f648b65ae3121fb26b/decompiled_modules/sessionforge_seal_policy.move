module 0x84dcddec5becd1ddfbf76d41df827af409c01e684f3239f648b65ae3121fb26b::sessionforge_seal_policy {
    struct Policy has key {
        id: 0x2::object::UID,
        admin: address,
    }

    public entry fun create_policy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Policy{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Policy>(v0);
    }

    fun has_policy_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg1);
        if (0x1::vector::length<u8>(&arg0) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v1) != *0x1::vector::borrow<u8>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public entry fun rotate_admin(arg0: &mut Policy, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        arg0.admin = arg1;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Policy, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        assert!(has_policy_prefix(arg0, 0x2::object::uid_to_bytes(&arg1.id)), 1);
    }

    // decompiled from Move bytecode v7
}

