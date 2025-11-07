module 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        collateral_price: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        debt_price: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        collateral_type: 0x1::type_name::TypeName,
        seized_ctoken_amount: u64,
        seized_collateral_amount: u64,
        ctokens_remaining: u64,
        debt_type: 0x1::type_name::TypeName,
        total_borrow_remaining: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        borrow_index: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        repay_amount: u64,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::ProtocolApp, arg1: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::ensure_version_matches<T0>(arg3);
        assert!(!0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::has_circuit_break_triggered<T0>(arg3), 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::error::market_under_circuit_break());
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::ensure_has_permission(arg0, 0x2::object::id<0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::PackageCallerCap>(arg1), 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::whitelist_admin::liquidation());
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let (v1, v2) = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::handle_liquidation<T0, T1, T2>(arg3, arg2, arg4, arg5, arg6, arg7, v0, arg8);
        let v3 = v1;
        let v4 = 0x1::type_name::get<T1>();
        let v5 = 0x1::type_name::get<T2>();
        let v6 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::borrow_obligation<T0>(arg3, arg2);
        let v7 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::emode::get_oracle_base_token(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::emode::borrow_emode_group(0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::emode_registry<T0>(arg3), 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::obligation::emode_group<T0>(v6)));
        let v8 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::obligation::ctoken_amount_by_coin<T0>(v6, v5);
        let (v9, v10) = if (0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::obligation::has_debt<T0>(v6, v4)) {
            let v11 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::obligation::debt<T0>(v6, v4);
            (0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::debt::unsafe_debt_amount(v11), *0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::debt::borrow_index(v11))
        } else {
            (0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::zero(), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::one())
        };
        let v12 = 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::borrow_liquidity_mining_mut<T0>(arg3);
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::liquidity_miner::update_obligation_reward_manager<T0, T1>(v12, 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::liquidity_miner::get_borrow_reward_type(), arg2, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(v9), arg7);
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::liquidity_miner::update_obligation_reward_manager<T0, T2>(v12, 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::liquidity_miner::get_deposit_reward_type(), arg2, v8, arg7);
        let v13 = LiquidateEvent{
            liquidator               : 0x2::tx_context::sender(arg8),
            market                   : 0x1::type_name::get<T0>(),
            obligation               : arg2,
            collateral_price         : 0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::user_oracle::get_price(arg6, 0x1::type_name::get<T2>(), v7, arg7),
            debt_price               : 0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::user_oracle::get_price(arg6, 0x1::type_name::get<T1>(), v7, arg7),
            collateral_type          : v5,
            seized_ctoken_amount     : v2,
            seized_collateral_amount : 0x2::coin::value<T2>(&v3),
            ctokens_remaining        : v8,
            debt_type                : v4,
            total_borrow_remaining   : v9,
            borrow_index             : v10,
            repay_amount             : 0x2::coin::value<T1>(&arg4),
            timestamp                : v0,
        };
        0x2::event::emit<LiquidateEvent>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v3, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

