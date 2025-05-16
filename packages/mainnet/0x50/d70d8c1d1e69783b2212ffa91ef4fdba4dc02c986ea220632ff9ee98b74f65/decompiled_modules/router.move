module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::router {
    struct TradedEvent<phantom T0, phantom T1> has copy, drop {
        pool_addr: address,
        trader: address,
        from: 0x1::type_name::TypeName,
        to: 0x1::type_name::TypeName,
        amount_in: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        amount_out: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        fee_rate: u64,
        sender: address,
    }

    public fun trade_exact_x_to_y<T0, T1>(arg0: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg7: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg8: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg9: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        assert!(v0 <= arg11, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETxExpired());
        let v1 = 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg0);
        let v2 = if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_config_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>>(arg1)) {
            if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg2)) {
                0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        assert!(!0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::is_paused<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolPaused());
        let v3 = 0x2::tx_context::sender(arg13);
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_last_trade_time_ms<T0, T1>(arg2, v3) + 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_trade_interval_ms<T0, T1>(arg1) <= v0, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETradeIntervalTooShort());
        let (v4, v5) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_base_amount_in_range<T0, T1>(arg1);
        let v6 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg5);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::ge(v6, v4) && 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::le(v6, v5), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EAmountInOutOfRange());
        let (v7, v8, v9, v10) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::utils::fetch_prices<T0, T1>(arg1, arg6, arg7, arg8, arg9, arg12);
        let v11 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v7, v8);
        let v12 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_diff_ratio(v11, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v9, v10));
        assert!(v12 <= 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_price_diff_ratio<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EMaxPriceDiffRatioExceeded());
        let v13 = if (v12 > 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_safe_price_diff_ratio<T0, T1>(arg1)) {
            v12
        } else {
            0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_fee_rate<T0, T1>(arg1)
        };
        let v14 = trade_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, v6, v13, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_protocol_fee_share<T0, T1>(arg1), v11, arg13);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::ge(v14, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg10)), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EInsufficientAmountOut());
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::update_last_trade_time_ms<T0, T1>(arg2, v3, arg12);
        let v15 = TradedEvent<T0, T1>{
            pool_addr  : v1,
            trader     : v3,
            from       : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_base_asset<T0, T1>(arg1),
            to         : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_quote_asset<T0, T1>(arg1),
            amount_in  : v6,
            amount_out : v14,
            fee_rate   : v13,
            sender     : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<TradedEvent<T0, T1>>(v15);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_quote_coin<T0, T1>(arg0, arg2, v14, arg13)
    }

    public fun trade_exact_y_to_x<T0, T1>(arg0: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg7: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg8: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg9: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        assert!(v0 <= arg11, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETxExpired());
        let v1 = 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg0);
        let v2 = if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_config_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>>(arg1)) {
            if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg2)) {
                0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        assert!(!0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::is_paused<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolPaused());
        let v3 = 0x2::tx_context::sender(arg13);
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_last_trade_time_ms<T0, T1>(arg2, v3) + 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_trade_interval_ms<T0, T1>(arg1) <= v0, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETradeIntervalTooShort());
        let (v4, v5) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_quote_amount_in_range<T0, T1>(arg1);
        let v6 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg5);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::ge(v6, v4) && 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::le(v6, v5), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EAmountInOutOfRange());
        let (v7, v8, v9, v10) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::utils::fetch_prices<T0, T1>(arg1, arg6, arg7, arg8, arg9, arg12);
        let v11 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v8, v7);
        let v12 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_diff_ratio(v11, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v10, v9));
        assert!(v12 <= 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_price_diff_ratio<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EMaxPriceDiffRatioExceeded());
        let v13 = if (v12 > 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_safe_price_diff_ratio<T0, T1>(arg1)) {
            v12
        } else {
            0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_fee_rate<T0, T1>(arg1)
        };
        let v14 = trade_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, v6, v13, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_protocol_fee_share<T0, T1>(arg1), v11, arg13);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::ge(v14, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg10)), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EInsufficientAmountOut());
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::update_last_trade_time_ms<T0, T1>(arg2, v3, arg12);
        let v15 = TradedEvent<T0, T1>{
            pool_addr  : v1,
            trader     : v3,
            from       : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_quote_asset<T0, T1>(arg1),
            to         : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_base_asset<T0, T1>(arg1),
            amount_in  : v6,
            amount_out : v14,
            fee_rate   : v13,
            sender     : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<TradedEvent<T0, T1>>(v15);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_base_coin<T0, T1>(arg0, arg2, v14, arg13)
    }

    public fun trade_x_to_exact_y<T0, T1>(arg0: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg7: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg8: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg9: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 <= arg10, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETxExpired());
        let v1 = 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg0);
        let v2 = if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_config_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>>(arg1)) {
            if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg2)) {
                0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        assert!(!0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::is_paused<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolPaused());
        let v3 = 0x2::tx_context::sender(arg12);
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_last_trade_time_ms<T0, T1>(arg2, v3) + 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_trade_interval_ms<T0, T1>(arg1) <= v0, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETradeIntervalTooShort());
        let (v4, v5, v6, v7) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::utils::fetch_prices<T0, T1>(arg1, arg6, arg7, arg8, arg9, arg11);
        let v8 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v4, v5);
        let v9 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_diff_ratio(v8, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v6, v7));
        assert!(v9 <= 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_price_diff_ratio<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EMaxPriceDiffRatioExceeded());
        let v10 = if (v9 > 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_safe_price_diff_ratio<T0, T1>(arg1)) {
            v9
        } else {
            0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_fee_rate<T0, T1>(arg1)
        };
        let v11 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg5);
        let v12 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v11, v8), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000 - v10)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000));
        let (v13, v14) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_base_amount_in_range<T0, T1>(arg1);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::ge(v12, v13) && 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::le(v12, v14), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EAmountInOutOfRange());
        trade_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, v12, v10, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_protocol_fee_share<T0, T1>(arg1), v8, arg12);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::update_last_trade_time_ms<T0, T1>(arg2, v3, arg11);
        let v15 = TradedEvent<T0, T1>{
            pool_addr  : v1,
            trader     : v3,
            from       : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_base_asset<T0, T1>(arg1),
            to         : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_quote_asset<T0, T1>(arg1),
            amount_in  : v12,
            amount_out : v11,
            fee_rate   : v10,
            sender     : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<TradedEvent<T0, T1>>(v15);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_quote_coin<T0, T1>(arg0, arg2, v11, arg12)
    }

    fun trade_x_to_y<T0, T1>(arg0: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg4: &mut 0x2::coin::Coin<T0>, arg5: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg6: u64, arg7: u64, arg8: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg9: &mut 0x2::tx_context::TxContext) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(arg5, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg6)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000));
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v0, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg7)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000));
        let v2 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(arg5, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_base_coin<T0, T1>(arg0, arg1, arg2, 0x2::coin::split<T0>(arg4, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v2), arg9));
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_base_fee_coin<T0, T1>(arg0, arg3, 0x2::coin::split<T0>(arg4, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(v0, v1)), arg9), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_total_liquidity_point<T0, T1>(arg2));
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_base_protocol_fee_coin<T0, T1>(arg0, arg3, 0x2::coin::split<T0>(arg4, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v1), arg9));
        0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v2, arg8)
    }

    public fun trade_y_to_exact_x<T0, T1>(arg0: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg7: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg8: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg9: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 <= arg10, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETxExpired());
        let v1 = 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg0);
        let v2 = if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_config_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>>(arg1)) {
            if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg2)) {
                0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg0) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        assert!(!0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::is_paused<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolPaused());
        let v3 = 0x2::tx_context::sender(arg12);
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_last_trade_time_ms<T0, T1>(arg2, v3) + 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_trade_interval_ms<T0, T1>(arg1) <= v0, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETradeIntervalTooShort());
        let (v4, v5, v6, v7) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::utils::fetch_prices<T0, T1>(arg1, arg6, arg7, arg8, arg9, arg11);
        let v8 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v5, v4);
        let v9 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_diff_ratio(v8, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v7, v6));
        assert!(v9 <= 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_price_diff_ratio<T0, T1>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EMaxPriceDiffRatioExceeded());
        let v10 = if (v9 > 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_safe_price_diff_ratio<T0, T1>(arg1)) {
            v9
        } else {
            0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_fee_rate<T0, T1>(arg1)
        };
        let v11 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg5);
        let v12 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v11, v8), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000 - v10)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000));
        let (v13, v14) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_quote_amount_in_range<T0, T1>(arg1);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::ge(v12, v13) && 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::le(v12, v14), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EAmountInOutOfRange());
        trade_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, v12, v10, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_protocol_fee_share<T0, T1>(arg1), v8, arg12);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::update_last_trade_time_ms<T0, T1>(arg2, v3, arg11);
        let v15 = TradedEvent<T0, T1>{
            pool_addr  : v1,
            trader     : v3,
            from       : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_quote_asset<T0, T1>(arg1),
            to         : 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_base_asset<T0, T1>(arg1),
            amount_in  : v12,
            amount_out : v11,
            fee_rate   : v10,
            sender     : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<TradedEvent<T0, T1>>(v15);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_base_coin<T0, T1>(arg0, arg2, v11, arg12)
    }

    fun trade_y_to_x<T0, T1>(arg0: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg4: &mut 0x2::coin::Coin<T1>, arg5: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg6: u64, arg7: u64, arg8: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg9: &mut 0x2::tx_context::TxContext) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(arg5, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg6)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000));
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v0, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg7)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(10000));
        let v2 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(arg5, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_quote_coin<T0, T1>(arg0, arg1, arg2, 0x2::coin::split<T1>(arg4, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v2), arg9));
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_quote_fee_coin<T0, T1>(arg0, arg3, 0x2::coin::split<T1>(arg4, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(v0, v1)), arg9), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_total_liquidity_point<T0, T1>(arg2));
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_quote_protocol_fee_coin<T0, T1>(arg0, arg3, 0x2::coin::split<T1>(arg4, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v1), arg9));
        0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v2, arg8)
    }

    // decompiled from Move bytecode v6
}

