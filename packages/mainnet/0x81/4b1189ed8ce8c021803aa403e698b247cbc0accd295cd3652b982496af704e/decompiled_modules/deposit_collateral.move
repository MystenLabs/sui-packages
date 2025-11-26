module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public fun deposit_collateral<T0>(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::assert_current_version(arg0);
        assert!(!0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::is_paused(arg2), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::market_paused_error());
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::zero_amount_error());
        assert!(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::deposit_collateral_locked(arg1) == false, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::is_collateral_active(arg2, v0), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::collateral_not_active_error());
        assert!(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::has_risk_model(arg2, v0) == true, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

