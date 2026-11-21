module 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::whitelist {
    struct WhitelistKey has copy, drop, store {
        addr: address,
    }

    struct WhitelistUpdated has copy, drop {
        contract_id: 0x2::object::ID,
        admin: address,
        addr: address,
        enabled: bool,
    }

    public(friend) fun batch_set_whitelist(arg0: &mut 0x2::object::UID, arg1: vector<address>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (set(arg0, v2, arg2)) {
                let v3 = WhitelistUpdated{
                    contract_id : v0,
                    admin       : 0x2::tx_context::sender(arg3),
                    addr        : v2,
                    enabled     : arg2,
                };
                0x2::event::emit<WhitelistUpdated>(v3);
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun is_whitelisted(arg0: &0x2::object::UID, arg1: address) : bool {
        let v0 = WhitelistKey{addr: arg1};
        0x2::dynamic_field::exists_with_type<WhitelistKey, bool>(arg0, v0)
    }

    fun set(arg0: &mut 0x2::object::UID, arg1: address, arg2: bool) : bool {
        if (is_whitelisted(arg0, arg1) == arg2) {
            return false
        };
        let v0 = WhitelistKey{addr: arg1};
        if (arg2) {
            0x2::dynamic_field::add<WhitelistKey, bool>(arg0, v0, true);
        } else {
            0x2::dynamic_field::remove<WhitelistKey, bool>(arg0, v0);
        };
        true
    }

    // decompiled from Move bytecode v7
}

