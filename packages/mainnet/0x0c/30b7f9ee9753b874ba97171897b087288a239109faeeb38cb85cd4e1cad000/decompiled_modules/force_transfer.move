module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::force_transfer {
    struct ForceTransferAbility has drop {
        dummy_field: bool,
    }

    public fun force_transfer<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, ForceTransferAbility>(arg0), 0);
        if (!0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::is_address_registered<T0>(arg1, arg3)) {
            let v0 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v0, arg3);
            0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::add_holder<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), v0);
        };
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::transfer_with_policy_cap<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3, arg4);
    }

    public fun force_join<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg2: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, ForceTransferAbility>(arg0), 0);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::join_with_policy_cap<T0>(arg1, arg2, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0));
    }

    public fun force_split<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, ForceTransferAbility>(arg0), 0);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::split_with_policy_cap<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3)
    }

    public fun force_transfer_amount<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, ForceTransferAbility>(arg0), 0);
        if (!0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::is_address_registered<T0>(arg1, arg3)) {
            let v0 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v0, arg3);
            0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::add_holder<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), v0);
        };
        let v1 = force_split<T0>(arg0, arg2, arg4, arg5);
        let v2 = &mut v1;
        force_transfer<T0>(arg0, arg1, v2, arg3, arg5);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::share<T0>(v1);
    }

    // decompiled from Move bytecode v7
}

