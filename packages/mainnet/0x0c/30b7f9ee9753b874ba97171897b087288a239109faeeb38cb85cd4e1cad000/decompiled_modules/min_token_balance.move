module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_token_balance {
    struct MinTokenBalanceAbility has drop {
        dummy_field: bool,
    }

    public fun enable_min_token_balance<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, MinTokenBalanceAbility>(arg0), 0);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_amount_rule::default_actions();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_amount_rule::add_for_action<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), 0x1::vector::pop_back<0x1::string::String>(&mut v0), arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v0);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_amount_rule::set_min_amount<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3);
    }

    public fun set_min_token_balance<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, MinTokenBalanceAbility>(arg0), 0);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_amount_rule::update_min_amount<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

