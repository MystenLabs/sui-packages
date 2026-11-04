module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::burn {
    struct BurnAbility has drop {
        dummy_field: bool,
    }

    struct Burned<phantom T0> has copy, drop {
        sender: address,
        owner: address,
        amount: u64,
    }

    public fun burn<T0>(arg0: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, BurnAbility>(arg0), 0);
        let v0 = Burned<T0>{
            sender : 0x2::tx_context::sender(arg2),
            owner  : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::token_owner<T0>(&arg1),
            amount : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::token_value<T0>(&arg1),
        };
        0x2::event::emit<Burned<T0>>(v0);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::burn<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::treasury_cap_mut<T0>(arg0), arg1);
    }

    public fun burn_amount<T0>(arg0: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, BurnAbility>(arg0), 0);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::split_with_treasury_cap<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::treasury_cap<T0>(arg0), arg2, arg3);
        burn<T0>(arg0, v0, arg3);
    }

    // decompiled from Move bytecode v7
}

