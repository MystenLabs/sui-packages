module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_transfer {
    struct GroupTransferAbility has drop {
        dummy_field: bool,
    }

    public fun allow_group_transfer<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, GroupTransferAbility>(arg0), 13906834273127628799);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::allow_group_rule::allow_group_pair<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3, arg4);
    }

    public fun disallow_group_transfer<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, GroupTransferAbility>(arg0), 13906834341847105535);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::new(arg2, arg3);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::allow_group_rule::disallow_group_pair<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), &v0, arg4);
    }

    public fun lock_until<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, GroupTransferAbility>(arg0), 13906834410566582271);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::lock_group_until_timestamp_rule::set_unlock_timestamp<T0>(arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg0), arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

