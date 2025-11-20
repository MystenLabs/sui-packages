module 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::swaps_common {
    public(friend) fun cetus_pool_id() : u64 {
        0
    }

    public(friend) fun decrease_sui_to_usdc_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1000050000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1000024999;
        };
        (v1 as u128)
    }

    public(friend) fun decrease_usdc_to_sui_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1000050000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000024999;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    public(friend) fun get_swap_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / (arg0 as u128)) as u64)
    }

    public(friend) fun get_target_quantity(arg0: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::Parameters, arg1: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::OrderManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: bool) : u64 {
        if (arg5 && arg3 >= arg4) {
            return 0
        };
        if (!arg5 && arg3 <= arg4) {
            return 0
        };
        let v0 = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::abs_diff(arg3, arg4) * 1000 / arg4 / 10000;
        if (v0 < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0)) {
            return 0
        };
        0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_manager::skew_quantity_based_on_position(arg1, arg0, arg2, 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_minimum_start_quantity(arg0) + 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_step_start_quantity(arg0) * (v0 - 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::swap_threshold_bps_times_1k(arg0)) / 1000, arg5)
    }

    public(friend) fun increase_sui_to_usdc_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000050000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000024999;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    public(friend) fun increase_usdc_to_sui_sqrt_price(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000050000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1000024999;
        };
        (v1 as u128)
    }

    public(friend) fun mmt_pool_id() : u64 {
        1
    }

    public(friend) fun turbos_pool_id() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

