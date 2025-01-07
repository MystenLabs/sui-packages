module 0x12ccc76a79f686371c407316848cd9566cccaf1d316b8574a452cce816d396e9::allowlist_rule {
    struct Allowlist has drop {
        dummy_field: bool,
    }

    public fun add_records<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
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

    public fun remove_records<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: vector<address>) {
        let v0 = config_mut<T0>(arg0, arg1);
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::bag::remove<address, bool>(v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_config<T0>(arg0), 0);
        let v0 = config<T0>(arg0);
        let v1 = 0x2::token::recipient<T0>(arg1);
        assert!(0x2::bag::contains<address>(v0, 0x2::token::sender<T0>(arg1)), 0);
        if (0x1::option::is_some<address>(&v1)) {
            assert!(0x2::bag::contains<address>(v0, *0x1::option::borrow<address>(&v1)), 0);
        };
        let v2 = Allowlist{dummy_field: false};
        0x2::token::add_approval<T0, Allowlist>(v2, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

