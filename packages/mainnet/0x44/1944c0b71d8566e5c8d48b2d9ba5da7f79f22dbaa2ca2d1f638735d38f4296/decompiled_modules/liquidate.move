module 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        collateral_price: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        debt_price: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        collateral_type: 0x1::type_name::TypeName,
        seized_ctoken_amount: u64,
        seized_collateral_amount: u64,
        ctokens_remaining: u64,
        debt_type: 0x1::type_name::TypeName,
        total_borrow_remaining: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        borrow_index: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        repay_amount: u64,
        timestamp: u64,
    }

    public fun liquidate<T0, T1, T2>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ProtocolApp, arg1: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::ensure_version_matches<T0>(arg3);
        assert!(!0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::has_circuit_break_triggered<T0>(arg3), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::error::market_under_circuit_break());
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ensure_has_permission(arg0, 0x2::object::id<0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::PackageCallerCap>(arg1), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::whitelist_admin::liquidation());
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let (v1, v2) = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::handle_liquidation<T0, T1, T2>(arg3, arg2, arg4, arg5, arg6, arg7, v0, arg8);
        let v3 = v1;
        let v4 = 0x1::type_name::get<T1>();
        let v5 = 0x1::type_name::get<T2>();
        let v6 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::borrow_obligation<T0>(arg3, arg2);
        let v7 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::emode::get_oracle_base_token(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::emode::borrow_emode_group(0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::emode_registry<T0>(arg3), 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::obligation::emode_group<T0>(v6)));
        let v8 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::obligation::ctoken_amount_by_coin<T0>(v6, v5);
        let (v9, v10) = if (0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::obligation::has_debt<T0>(v6, v4)) {
            let v11 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::obligation::debt<T0>(v6, v4);
            (0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::debt::unsafe_debt_amount(v11), *0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::debt::borrow_index(v11))
        } else {
            (0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::zero(), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::one())
        };
        let v12 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::borrow_liquidity_mining_mut<T0>(arg3);
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::liquidity_miner::update_obligation_reward_manager<T0, T1>(v12, 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::liquidity_miner::get_borrow_reward_type(), arg2, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::floor(v9), arg7);
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::liquidity_miner::update_obligation_reward_manager<T0, T2>(v12, 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::liquidity_miner::get_deposit_reward_type(), arg2, v8, arg7);
        let v13 = LiquidateEvent{
            liquidator               : 0x2::tx_context::sender(arg8),
            market                   : 0x1::type_name::get<T0>(),
            obligation               : arg2,
            collateral_price         : 0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::user_oracle::get_price(arg6, 0x1::type_name::get<T2>(), v7, arg7),
            debt_price               : 0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::user_oracle::get_price(arg6, 0x1::type_name::get<T1>(), v7, arg7),
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

