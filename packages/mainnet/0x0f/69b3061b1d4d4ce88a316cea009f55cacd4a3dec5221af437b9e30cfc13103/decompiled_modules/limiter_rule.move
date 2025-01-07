module 0xf69b3061b1d4d4ce88a316cea009f55cacd4a3dec5221af437b9e30cfc13103::limiter_rule {
    struct Limiter has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        limits: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public fun get_config<T0>(arg0: &0x2::token::TokenPolicy<T0>) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        let v0 = Limiter{dummy_field: false};
        0x2::token::rule_config<T0, Limiter, Config>(v0, arg0).limits
    }

    public fun set_config<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Limiter>(arg0)) {
            let v0 = Config{limits: arg2};
            let v1 = Limiter{dummy_field: false};
            0x2::token::add_rule_config<T0, Limiter, Config>(v1, arg0, arg1, v0, arg3);
        } else {
            let v2 = Limiter{dummy_field: false};
            0x2::token::rule_config_mut<T0, Limiter, Config>(v2, arg0, arg1).limits = arg2;
        };
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Limiter>(arg0)) {
            let v0 = Limiter{dummy_field: false};
            0x2::token::add_approval<T0, Limiter>(v0, arg1, arg2);
            return
        };
        let v1 = Limiter{dummy_field: false};
        let v2 = 0x2::token::rule_config<T0, Limiter, Config>(v1, arg0);
        let v3 = 0x2::token::action<T0>(arg1);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&v2.limits, &v3)) {
            let v4 = Limiter{dummy_field: false};
            0x2::token::add_approval<T0, Limiter>(v4, arg1, arg2);
            return
        };
        let v5 = 0x2::token::action<T0>(arg1);
        assert!(0x2::token::amount<T0>(arg1) <= *0x2::vec_map::get<0x1::string::String, u64>(&v2.limits, &v5), 0);
        let v6 = Limiter{dummy_field: false};
        0x2::token::add_approval<T0, Limiter>(v6, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

