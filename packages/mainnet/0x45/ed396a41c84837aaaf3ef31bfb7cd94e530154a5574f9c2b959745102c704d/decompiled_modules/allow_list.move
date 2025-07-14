module 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::allow_list {
    struct Allowlist has drop {
        dummy_field: bool,
    }

    public entry fun add_records<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!has_config<T0>(arg0)) {
            let v0 = Allowlist{dummy_field: false};
            0x2::token::add_rule_config<T0, Allowlist, 0x2::bag::Bag>(v0, arg0, arg1, 0x2::bag::new(arg3), arg3);
        };
        let v1 = config_mut<T0>(arg0, arg1);
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::bag::add<address, bool>(v1, 0x1::vector::pop_back<address>(&mut arg2), true);
        };
    }

    fun config<T0>(arg0: &0x2::token::TokenPolicy<T0>) : &0x2::bag::Bag {
        let v0 = Allowlist{dummy_field: false};
        0x2::token::rule_config<T0, Allowlist, 0x2::bag::Bag>(v0, arg0)
    }

    fun config_mut<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>) : &mut 0x2::bag::Bag {
        let v0 = Allowlist{dummy_field: false};
        0x2::token::rule_config_mut<T0, Allowlist, 0x2::bag::Bag>(v0, arg0, arg1)
    }

    fun has_config<T0>(arg0: &0x2::token::TokenPolicy<T0>) : bool {
        0x2::token::has_rule_config_with_type<T0, Allowlist, 0x2::bag::Bag>(arg0)
    }

    public fun is_allowed<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: address) : bool {
        has_config<T0>(arg0) && 0x2::bag::contains<address>(config<T0>(arg0), arg1)
    }

    public entry fun remove_records<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = config_mut<T0>(arg0, arg1);
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::bag::contains<address>(v0, v1)) {
                0x2::bag::remove<address, bool>(v0, v1);
            };
        };
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!has_config<T0>(arg0)) {
            let v0 = Allowlist{dummy_field: false};
            0x2::token::add_approval<T0, Allowlist>(v0, arg1, arg2);
            return
        };
        let v1 = config<T0>(arg0);
        let v2 = 0x2::tx_context::sender(arg2);
        if (!0x2::bag::contains<address>(v1, v2)) {
            let v3 = 0x2::token::recipient<T0>(arg1);
            if (0x1::option::is_some<address>(&v3)) {
                let v4 = *0x1::option::borrow<address>(&v3);
                assert!(v2 == v4 || 0x2::bag::contains<address>(v1, v4), 0);
            };
        };
        let v5 = Allowlist{dummy_field: false};
        0x2::token::add_approval<T0, Allowlist>(v5, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

