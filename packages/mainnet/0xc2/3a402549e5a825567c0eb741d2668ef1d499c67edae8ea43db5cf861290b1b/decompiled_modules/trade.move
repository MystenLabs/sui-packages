module 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::trade {
    public fun execute_decrease<T0, T1, T2>(arg0: &mut 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::KeeperCap, arg2: u64, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::market_feed_id<T0>(arg0, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::request_market_id<T0>(arg0, arg2));
        let (v1, v2) = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::execute_decrease<T0>(arg0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::KeeperCap>(arg1)), 0x2::tx_context::sender(arg8), arg2, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pyth_price::read(arg3, &v0), collateral_price_for<T0, T1, T2>(arg0, arg5, arg6, arg4, arg7, true), 0x2::clock::timestamp_ms(arg7));
        send<T0>(v2, v1, arg8);
    }

    public fun execute_increase<T0, T1, T2>(arg0: &mut 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::KeeperCap, arg2: u64, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &0x2::clock::Clock) {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::market_feed_id<T0>(arg0, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::request_market_id<T0>(arg0, arg2));
        0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::execute_increase<T0>(arg0, arg1, arg2, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pyth_price::read(arg3, &v0), collateral_price<T0, T1, T2>(arg0, arg5, arg6, arg4, arg7), 0x2::clock::timestamp_ms(arg7));
    }

    public fun execute_withdraw<T0, T1, T2>(arg0: &mut 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::KeeperCap, arg2: u64, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::market_feed_id<T0>(arg0, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::request_market_id<T0>(arg0, arg2));
        let (v1, v2) = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::execute_withdraw<T0>(arg0, arg1, arg2, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pyth_price::read(arg3, &v0), collateral_price<T0, T1, T2>(arg0, arg5, arg6, arg4, arg7), 0x2::clock::timestamp_ms(arg7));
        send<T0>(v2, v1, arg8);
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::Exchange<T0>, arg1: address, arg2: u64, arg3: bool, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::market_feed_id<T0>(arg0, arg2);
        let v1 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::liquidate<T0>(arg0, arg1, arg2, arg3, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pyth_price::read(arg4, &v0), collateral_price_for<T0, T1, T2>(arg0, arg6, arg7, arg5, arg8, true), 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9));
        let v2 = 0x2::tx_context::sender(arg9);
        send<T0>(v1, v2, arg9);
    }

    public fun collateral_price<T0, T1, T2>(arg0: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::CollateralPrice {
        collateral_price_for<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, false)
    }

    fun collateral_price_for<T0, T1, T2>(arg0: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: bool) : 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::CollateralPrice {
        assert!(0x2::object::id<0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle>(arg1) == 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::pool_oracle_id<T0>(arg0), 200);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2) == 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::pool_id(arg1), 200);
        assert!(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::collateral_type(arg1) == 0x1::type_name::with_defining_ids<T0>(), 200);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::twap(arg1, v0);
        assert!(0x1::option::is_some<u128>(&v1), 201);
        let v2 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::sui_feed_id<T0>(arg0);
        let v3 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pyth_price::read(arg3, &v2);
        0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::check_oracle_price<T0>(arg0, &v3, v0, arg5);
        0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::collateral_price_at(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::spot_price<T1, T2>(arg2, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::collateral_is_a(arg1)), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(&v3), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18()), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(0x1::option::destroy_some<u128>(v1), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(&v3), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18()), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::last_ms(arg1))
    }

    public fun execute_own_decrease<T0, T1, T2>(arg0: &mut 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::Exchange<T0>, arg1: u64, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::market_feed_id<T0>(arg0, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::request_market_id<T0>(arg0, arg1));
        let (v1, v2) = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange::execute_decrease<T0>(arg0, 0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg7), arg1, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pyth_price::read(arg2, &v0), collateral_price_for<T0, T1, T2>(arg0, arg4, arg5, arg3, arg6, true), 0x2::clock::timestamp_ms(arg6));
        send<T0>(v2, v1, arg7);
    }

    fun send<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

