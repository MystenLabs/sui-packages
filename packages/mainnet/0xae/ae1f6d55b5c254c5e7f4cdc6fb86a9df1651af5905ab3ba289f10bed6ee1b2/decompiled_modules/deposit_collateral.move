module 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public fun deposit_collateral<T0>(arg0: &0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::version::Version, arg1: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation, arg2: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::version::assert_current_version(arg0);
        assert!(!0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::is_paused(arg2), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::market_paused_error());
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::zero_amount_error());
        assert!(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::deposit_collateral_locked(arg1) == false, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::is_collateral_active(arg2, v0), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::collateral_not_active_error());
        assert!(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::has_risk_model(arg2, v0) == true, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

