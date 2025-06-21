module 0x67b217f486e48d7fa9fdee83f2fde54823d4da77ef72c59875e2c25c1ca8d37d::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        fee_tier: u64,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    public fun calculate_min_usdc_output(arg0: u64) : u64 {
        arg0 * 105 / 100 * 95 / 100 / 1000
    }

    public fun calculate_real_turbos_output(arg0: u64) : u64 {
        let v0 = arg0 * 1050000 / 1000000000;
        v0 - v0 * 3000 / 1000000
    }

    public fun calculate_turbos_fee(arg0: u64) : u64 {
        arg0 * 3000 / 1000000
    }

    public fun get_turbos_package() : address {
        0x67b217f486e48d7fa9fdee83f2fde54823d4da77ef72c59875e2c25c1ca8d37d::constants::turbos_package()
    }

    public fun get_turbos_sui_usdc_pool() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun is_turbos_operational() : bool {
        0x67b217f486e48d7fa9fdee83f2fde54823d4da77ef72c59875e2c25c1ca8d37d::constants::turbos_package() != @0x0
    }

    public fun validate_sui_usdc_swap(arg0: u64, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : bool {
        assert!(arg0 > 0, 8001);
        assert!(arg1 > 0, 8004);
        assert!(arg2 != @0x0, 8003);
        let v0 = TurbosSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : arg2,
            fee_tier       : 3000,
            method         : b"ptb_validation_call",
            package        : 0x67b217f486e48d7fa9fdee83f2fde54823d4da77ef72c59875e2c25c1ca8d37d::constants::turbos_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TurbosSwapExecuted>(v0);
        true
    }

    public fun validate_turbos_ptb_params(arg0: u64, arg1: u64, arg2: address) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 != @0x0
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

