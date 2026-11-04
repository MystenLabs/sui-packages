module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::mint {
    struct MintAbility has drop {
        dummy_field: bool,
    }

    struct Minted<phantom T0> has copy, drop {
        sender: address,
        owner: address,
        amount: u64,
    }

    public fun mint<T0>(arg0: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, 0x2::token::ActionRequest<T0>) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, MintAbility>(arg0), 0);
        let v0 = Minted<T0>{
            sender : 0x2::tx_context::sender(arg2),
            owner  : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<Minted<T0>>(v0);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::from_coin<T0>(0x2::coin::mint<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::treasury_cap_mut<T0>(arg0), arg1, arg2), arg2)
    }

    public fun force_mint<T0>(arg0: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, MintAbility>(arg0), 0);
        if (!0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::is_address_registered<T0>(arg1, arg3)) {
            let v0 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v0, arg3);
            0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::add_holder<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), v0);
        };
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::mint<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::treasury_cap_mut<T0>(arg0), arg2, arg3, arg4);
        let v1 = Minted<T0>{
            sender : 0x2::tx_context::sender(arg4),
            owner  : arg3,
            amount : arg2,
        };
        0x2::event::emit<Minted<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

