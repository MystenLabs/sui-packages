module 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidate {
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

    public fun liquidate<T0, T1, T2>(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::ensure_version_matches<T0>(arg3);
        assert!(!0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::has_circuit_break_triggered<T0>(arg3), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::error::market_under_circuit_break());
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ensure_has_permission(arg0, 0x2::object::id<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::PackageCallerCap>(arg1), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::whitelist_admin::liquidation());
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let (v1, v2) = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::handle_liquidation<T0, T1, T2>(arg3, arg2, arg4, arg5, arg6, arg7, v0, arg8);
        let v3 = v1;
        let v4 = 0x1::type_name::get<T1>();
        let v5 = 0x1::type_name::get<T2>();
        let v6 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::borrow_obligation<T0>(arg3, arg2);
        let v7 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode::get_oracle_base_token(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::emode::borrow_emode_group(0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::emode_registry<T0>(arg3), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::emode_group<T0>(v6)));
        let v8 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::ctoken_amount_by_coin<T0>(v6, v5);
        let (v9, v10) = if (0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::has_debt<T0>(v6, v4)) {
            let v11 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::obligation::debt<T0>(v6, v4);
            (0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::debt::unsafe_debt_amount(v11), *0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::debt::borrow_index(v11))
        } else {
            (0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::zero(), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::one())
        };
        let v12 = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::borrow_liquidity_mining_mut<T0>(arg3);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::update_obligation_reward_manager<T0, T1>(v12, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::get_borrow_reward_type(), arg2, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::floor(v9), arg7);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::update_obligation_reward_manager<T0, T2>(v12, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::liquidity_miner::get_deposit_reward_type(), arg2, v8, arg7);
        let v13 = LiquidateEvent{
            liquidator               : 0x2::tx_context::sender(arg8),
            market                   : 0x1::type_name::get<T0>(),
            obligation               : arg2,
            collateral_price         : 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::user_oracle::get_price(arg6, 0x1::type_name::get<T2>(), v7, arg7),
            debt_price               : 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::user_oracle::get_price(arg6, 0x1::type_name::get<T1>(), v7, arg7),
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

