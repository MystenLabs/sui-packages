module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public fun deposit_collateral<T0>(arg0: &0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::Version, arg1: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg2: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::version::assert_current_version(arg0);
        assert!(!0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::is_paused(arg2), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::market_paused_error());
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::zero_amount_error());
        assert!(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::deposit_collateral_locked(arg1) == false, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::is_collateral_active(arg2, v0), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::collateral_not_active_error());
        assert!(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::has_risk_model(arg2, v0) == true, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

