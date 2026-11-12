module 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::reader {
    fun simulate<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg3: u128, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::debt_decimals<T0, T1>(arg0);
        let v1 = if (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::topmost_tick<T0, T1>(arg0) == 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()) {
            let v2 = arg5 && (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::absorbed_debt_amount<T0, T1>(arg0) > 0 || 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::absorbed_col_amount<T0, T1>(arg0) > 0);
            !v2
        } else {
            false
        };
        assert!(!v1, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::top_tick_does_not_exist());
        let v3 = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::scale_amounts((arg4 as u128), v0);
        let (v4, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_exchange_prices<T0>(arg1, arg6);
        let (_, v7) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_exchange_prices<T1>(arg2, arg6);
        let (_, _, v10, v11) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::load_exchange_prices<T0, T1>(arg0, v4, v7, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg6));
        let (v12, v13, v14) = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::oracle_math::get_ticks_from_oracle_price<T0, T1>(arg0, arg3, v10, v11);
        if (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::topmost_tick<T0, T1>(arg0), v14)) {
            let (_, _, v17) = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::absorb_walk::simulate_absorb<T0, T1>(arg0, v14);
            assert!(v3 == 0 || v17, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::absorb_then_liquidate_unsupported());
            return (0, 0)
        };
        assert!(v3 >= 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::get_minimum_debt(v0), 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_liquidation_amt());
        let v18 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v3, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::exchange_prices_precision(), v11);
        assert!(!(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::get_total_borrow<T0, T1>(arg0) / 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::billion() > v18), 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_liquidation_amt());
        let (v19, v20) = if (arg5) {
            (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::absorbed_debt_amount<T0, T1>(arg0), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::absorbed_col_amount<T0, T1>(arg0))
        } else {
            (0, 0)
        };
        let (v21, v22) = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::liquidate_walk::run<T0, T1>(arg0, v12, v13, v18, v19, v20);
        let v23 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_ceil_u128(v21, v11, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::exchange_prices_precision());
        let v24 = v23;
        let v25 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v22, v10, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::exchange_prices_precision());
        let v26 = v25;
        if (v23 > v3) {
            assert!(v23 - v3 <= 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::max_liquidation_rounding_diff(), 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_liquidation());
            v26 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v25, v3, v23);
            v24 = v3;
        };
        assert!(v24 != 0, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_liquidation());
        ((0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::unscale_amounts_up(v24, v0) as u64), (0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::unscale_amounts(v26, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::col_decimals<T0, T1>(arg0)) as u64))
    }

    public fun simulate_liquidation<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg3: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64) {
        simulate<T0, T1>(arg0, arg1, arg2, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::oracle_math::get_exchange_rate_liquidate<T0, T1>(arg0, arg3), arg4, arg5, arg6)
    }

    public fun simulate_liquidation_at_rate<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg3: u128, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64) {
        simulate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

