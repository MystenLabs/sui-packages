module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::soft_pause {
    struct SoftPauseAbility has drop {
        dummy_field: bool,
    }

    struct TokenSoftPaused<phantom T0> has copy, drop {
        sender: address,
        is_paused: bool,
    }

    public fun pause_token<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, SoftPauseAbility>(arg0), 0);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::rules::enabled_actions();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            0x2::token::add_rule_for_action<T0, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::unprovable_rule::UnprovableRule>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), 0x1::vector::pop_back<0x1::string::String>(&mut v0), arg2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v0);
        let v2 = TokenSoftPaused<T0>{
            sender    : 0x2::tx_context::sender(arg2),
            is_paused : true,
        };
        0x2::event::emit<TokenSoftPaused<T0>>(v2);
    }

    public fun resume_token<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, SoftPauseAbility>(arg0), 0);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::rules::enabled_actions();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            0x2::token::remove_rule_for_action<T0, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::unprovable_rule::UnprovableRule>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), 0x1::vector::pop_back<0x1::string::String>(&mut v0), arg2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v0);
        let v2 = TokenSoftPaused<T0>{
            sender    : 0x2::tx_context::sender(arg2),
            is_paused : false,
        };
        0x2::event::emit<TokenSoftPaused<T0>>(v2);
    }

    // decompiled from Move bytecode v7
}

