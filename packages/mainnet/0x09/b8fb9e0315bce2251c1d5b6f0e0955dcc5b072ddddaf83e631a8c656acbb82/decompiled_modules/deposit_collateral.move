module 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::version::Version, arg1: &mut 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::obligation::Obligation, arg2: &mut 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::version::assert_current_version(arg0);
        assert!(0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::whitelist::is_address_allowed(0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::error::whitelist_error());
        assert!(0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::obligation::deposit_collateral_locked(arg1) == false, 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::market::is_collateral_active(arg2, v0), 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::error::collateral_not_active_error());
        assert!(0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::market::has_risk_model(arg2, v0) == true, 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

