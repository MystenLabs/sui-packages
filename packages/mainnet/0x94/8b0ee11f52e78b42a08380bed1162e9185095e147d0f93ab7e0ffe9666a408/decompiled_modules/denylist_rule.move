module 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::denylist_rule {
    struct Denylist has drop {
        dummy_field: bool,
    }

    public fun add_records<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!has_config<T0>(arg0)) {
            let v0 = Denylist{dummy_field: false};
            0x2::token::add_rule_config<T0, Denylist, 0x2::bag::Bag>(v0, arg0, arg1, 0x2::bag::new(arg3), arg3);
        };
        let v1 = config_mut<T0>(arg0, arg1);
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::bag::add<address, bool>(v1, 0x1::vector::pop_back<address>(&mut arg2), true);
        };
    }

    fun config<T0>(arg0: &0x2::token::TokenPolicy<T0>) : &0x2::bag::Bag {
        let v0 = Denylist{dummy_field: false};
        0x2::token::rule_config<T0, Denylist, 0x2::bag::Bag>(v0, arg0)
    }

    fun config_mut<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>) : &mut 0x2::bag::Bag {
        let v0 = Denylist{dummy_field: false};
        0x2::token::rule_config_mut<T0, Denylist, 0x2::bag::Bag>(v0, arg0, arg1)
    }

    fun has_config<T0>(arg0: &0x2::token::TokenPolicy<T0>) : bool {
        0x2::token::has_rule_config_with_type<T0, Denylist, 0x2::bag::Bag>(arg0)
    }

    public fun remove_records<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
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
            let v0 = Denylist{dummy_field: false};
            0x2::token::add_approval<T0, Denylist>(v0, arg1, arg2);
            return
        };
        let v1 = config<T0>(arg0);
        let v2 = 0x2::token::recipient<T0>(arg1);
        assert!(!0x2::bag::contains<address>(v1, 0x2::token::sender<T0>(arg1)), 0);
        if (0x1::option::is_some<address>(&v2)) {
            assert!(!0x2::bag::contains<address>(v1, *0x1::option::borrow<address>(&v2)), 0);
        };
        let v3 = Denylist{dummy_field: false};
        0x2::token::add_approval<T0, Denylist>(v3, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

