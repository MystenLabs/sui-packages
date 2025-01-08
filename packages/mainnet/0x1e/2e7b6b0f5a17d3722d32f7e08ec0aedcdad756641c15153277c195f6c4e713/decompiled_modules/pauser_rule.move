module 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule {
    struct Pauser has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        paused: bool,
    }

    public fun paused<T0>(arg0: &0x2::token::TokenPolicy<T0>) : bool {
        let v0 = Pauser{dummy_field: false};
        0x2::token::rule_config<T0, Pauser, Config>(v0, arg0).paused
    }

    public fun set_config<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Pauser>(arg0)) {
            let v0 = Config{paused: arg2};
            let v1 = Pauser{dummy_field: false};
            0x2::token::add_rule_config<T0, Pauser, Config>(v1, arg0, arg1, v0, arg3);
        } else {
            let v2 = Pauser{dummy_field: false};
            0x2::token::rule_config_mut<T0, Pauser, Config>(v2, arg0, arg1).paused = arg2;
        };
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Pauser>(arg0)) {
            let v0 = Pauser{dummy_field: false};
            0x2::token::add_approval<T0, Pauser>(v0, arg1, arg2);
            return
        };
        let v1 = Pauser{dummy_field: false};
        assert!(!0x2::token::rule_config<T0, Pauser, Config>(v1, arg0).paused, 200);
        let v2 = Pauser{dummy_field: false};
        0x2::token::add_approval<T0, Pauser>(v2, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

