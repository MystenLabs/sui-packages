module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::allow_list_rule {
    struct AllowListRule has drop {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, AllowListRule>(arg0, arg1, 0x2::token::transfer_action(), arg2);
    }

    public fun prove<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::action<T0>(arg1) == 0x2::token::transfer_action(), 9223372182883663873);
        let v0 = 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::transfer_config::get_transfer_flag<T0>(arg0);
        if (v0 == 1) {
            abort 9223372195768696835
        };
        if (v0 == 2) {
            let v1 = 0x2::token::recipient<T0>(arg1);
            assert!(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::investors_config::is_whitelisted<T0>(arg0, *0x1::option::borrow<address>(&v1)), 9223372204358762501);
            assert!(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::investors_config::is_whitelisted<T0>(arg0, 0x2::token::sender<T0>(arg1)), 9223372208653860871);
        };
        let v2 = AllowListRule{dummy_field: false};
        0x2::token::add_approval<T0, AllowListRule>(v2, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

