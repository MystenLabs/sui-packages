module 0x17e06c694bc7b3f6c1608741f11967109fb10efd676176e139b6cb605af68101::dex_turbos {
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

    public fun calculate_turbos_fee(arg0: u64) : u64 {
        arg0 * 3000 / 1000000
    }

    public fun get_turbos_package() : address {
        0x17e06c694bc7b3f6c1608741f11967109fb10efd676176e139b6cb605af68101::constants::turbos_package()
    }

    public fun get_turbos_sui_usdc_pool() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun is_turbos_operational() : bool {
        0x17e06c694bc7b3f6c1608741f11967109fb10efd676176e139b6cb605af68101::constants::turbos_package() != @0x0
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 8001);
        assert!(arg2 > 0, 8004);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 8003);
        let v2 = TurbosSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            fee_tier       : 3000,
            method         : b"ptb_external_package_call",
            package        : 0x17e06c694bc7b3f6c1608741f11967109fb10efd676176e139b6cb605af68101::constants::turbos_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TurbosSwapExecuted>(v2);
        turbos_external_swap_direct(arg0, arg1, arg2, v1, arg4);
    }

    public fun turbos_external_delivery_impl(arg0: u64, arg1: address) {
    }

    public fun turbos_external_swap_direct(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 8001);
        assert!(arg2 > 0, 8004);
        assert!(arg1 != @0x0, 8003);
        let v1 = calculate_min_usdc_output(v0);
        assert!(v1 >= arg2, 8001);
        turbos_pure_swap_function(arg0, v1, arg3);
    }

    public fun turbos_pure_swap_function(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address) {
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg0));
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

