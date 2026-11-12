module 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::oracle_math {
    public(friend) fun get_exchange_rate_liquidate<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote) : u128 {
        assert!(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::oracle<T0, T1>(arg0) == 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::oracle_id(arg1), 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_oracle_price());
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::rate_liquidate(arg1)
    }

    public(friend) fun get_ticks_from_oracle_price<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: u128, arg2: u128, arg3: u128) : (u128, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick) {
        let v0 = arg1 > 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::max_oracle_price() || arg1 == 0;
        assert!(!v0, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_oracle_price());
        let v1 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(arg1, arg2, arg3);
        let v2 = v1;
        assert!(v1 != 0, 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_oracle_price());
        if (v1 > 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::max_oracle_price_after_ex_price()) {
            v2 = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::max_oracle_price_after_ex_price();
        };
        let v3 = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::four_decimals();
        let v4 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v2, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::zero_tick_scaled_ratio(), 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::rate_output_precision());
        let v5 = 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::three_decimals();
        let (v6, _) = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_tick_at_ratio(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v4, (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::liquidation_threshold<T0, T1>(arg0) as u128), v5));
        let (v8, _) = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::get_tick_at_ratio(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(v4, (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::liquidation_max_limit<T0, T1>(arg0) as u128), v5));
        (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants::rate_output_precision_squared() / 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_ceil_u128(arg1, arg2, arg3), v3 + (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::liquidation_penalty<T0, T1>(arg0) as u128), v3), v6, v8)
    }

    // decompiled from Move bytecode v7
}

