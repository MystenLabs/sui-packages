module 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        borrow_index: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg1: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::obligation::ObligationOwnerCap, arg2: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg3: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ensure_version_matches(arg0);
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::validate_market<T0>(arg0, arg2);
        assert!(!0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::has_circuit_break_triggered<T0>(arg2), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2, v3) = 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::handle_borrow<T0, T1>(arg2, 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::obligation::id(arg1), arg4, arg3, arg5, arg6, v0);
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::liquidity_miner::update_obligation_reward_manager<T0, T1>(0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::borrow_liquidity_mining_mut<T0>(arg2), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::liquidity_miner::get_borrow_reward_type(), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::obligation::id(arg1), 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::floor(v3), arg6);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg7),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::obligation::id(arg1),
            asset        : 0x1::type_name::with_defining_ids<T1>(),
            amount       : arg4,
            total_borrow : v3,
            borrow_index : v2,
            time         : v0,
        };
        0x2::event::emit<BorrowEvent>(v4);
        0x2::coin::from_balance<T1>(v1, arg7)
    }

    // decompiled from Move bytecode v7
}

