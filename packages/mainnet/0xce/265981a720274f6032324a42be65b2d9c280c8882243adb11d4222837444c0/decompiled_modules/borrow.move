module 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        total_borrow: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        borrow_index: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg1: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::obligation::ObligationOwnerCap, arg2: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ensure_version_matches(arg0);
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::validate_market<T0>(arg0, arg2);
        assert!(!0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::has_circuit_break_triggered<T0>(arg2), 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::error::market_under_circuit_break());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let (v1, v2, v3) = 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::handle_borrow<T0, T1>(arg2, 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::obligation::id(arg1), arg4, arg3, arg5, arg6, v0);
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::liquidity_miner::update_obligation_reward_manager<T0, T1>(0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::borrow_liquidity_mining_mut<T0>(arg2), 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::liquidity_miner::get_borrow_reward_type(), 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::obligation::id(arg1), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(v3), arg6);
        let v4 = BorrowEvent{
            borrower     : 0x2::tx_context::sender(arg7),
            market       : 0x1::type_name::with_defining_ids<T0>(),
            obligation   : 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::obligation::id(arg1),
            asset        : 0x1::type_name::with_defining_ids<T1>(),
            amount       : arg4,
            total_borrow : v3,
            borrow_index : v2,
            time         : v0,
        };
        0x2::event::emit<BorrowEvent>(v4);
        0x2::coin::from_balance<T1>(v1, arg7)
    }

    // decompiled from Move bytecode v6
}

