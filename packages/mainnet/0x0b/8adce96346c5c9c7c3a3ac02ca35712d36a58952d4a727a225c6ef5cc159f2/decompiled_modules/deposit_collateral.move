module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public fun deposit_collateral<T0>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::Version, arg1: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg2: &mut 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::version::assert_current_version(arg0);
        assert!(!0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::is_paused(arg2), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::market_paused_error());
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::zero_amount_error());
        assert!(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::deposit_collateral_locked(arg1) == false, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::is_collateral_active(arg2, v0), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::collateral_not_active_error());
        assert!(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::has_risk_model(arg2, v0) == true, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

