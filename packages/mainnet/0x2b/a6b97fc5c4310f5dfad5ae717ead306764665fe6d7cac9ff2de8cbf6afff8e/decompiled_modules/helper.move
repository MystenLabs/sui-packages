module 0x2ba6b97fc5c4310f5dfad5ae717ead306764665fe6d7cac9ff2de8cbf6afff8e::helper {
    public fun calculate_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg3 >= arg4) {
            return 0
        };
        let v0 = 0x3::sui_system::pool_exchange_rates(arg0, &arg1);
        let v1 = pool_token_exchange_rate_at_epoch(v0, arg3);
        let v2 = get_sui_amount(&v1);
        let v3 = pool_token_exchange_rate_at_epoch(v0, arg4);
        let v4 = if (v2 == 0) {
            (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256((arg2 as u256), (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_to_u128(get_sui_amount(&v3), 1) as u256), (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_to_u128(1, get_token_amount(&v3)) as u256)) as u64)
        } else {
            (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256((arg2 as u256), (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_to_u128(get_sui_amount(&v3), get_token_amount(&v1)) as u256), (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_to_u128(v2, get_token_amount(&v3)) as u256)) as u64)
        };
        v4 - arg2
    }

    public fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate) : u64 {
        0x3::staking_pool::sui_amount(arg0)
    }

    public fun get_token_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate) : u64 {
        0x3::staking_pool::pool_token_amount(arg0)
    }

    public fun pool_token_exchange_rate_at_epoch(arg0: &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate>, arg1: u64) : 0x3::staking_pool::PoolTokenExchangeRate {
        *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

