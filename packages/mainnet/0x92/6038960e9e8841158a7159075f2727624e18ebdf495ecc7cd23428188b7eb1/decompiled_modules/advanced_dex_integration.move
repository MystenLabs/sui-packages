module 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::advanced_dex_integration {
    struct DexIntegrationConfig has store, key {
        id: 0x2::object::UID,
        enabled_dexes: vector<u8>,
        min_liquidity_threshold: u64,
        max_slippage_bps: u64,
        owner: address,
    }

    struct SwapParams has copy, drop {
        pool_address: address,
        amount_in: u64,
        min_amount_out: u64,
        deadline: u64,
        fee_bps: u64,
    }

    struct SwapExecuted has copy, drop {
        dex_id: u8,
        pool_address: address,
        amount_in: u64,
        amount_out: u64,
        fee_paid: u64,
        timestamp: u64,
    }

    public fun calculate_optimal_swap_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * arg2 / 10000;
        if (arg1 <= v0) {
            arg1
        } else {
            v0
        }
    }

    public fun estimate_swap_output(arg0: u64, arg1: u8, arg2: u64) : u64 {
        let v0 = if (arg2 > 0) {
            arg0 * 100 / arg2
        } else {
            0
        };
        let v1 = arg0 * get_dex_fee_bps(arg1) / 10000 + arg0 * v0 / 10000;
        if (arg0 > v1) {
            arg0 - v1
        } else {
            0
        }
    }

    public fun execute_cross_dex_arbitrage<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg6) <= arg5, 204);
        let v0 = if (arg1 == 2) {
            swap_on_cetus_clmm<T0, T1>(arg0, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, arg3, arg5, arg6, arg7)
        } else if (arg1 == 3) {
            swap_on_turbos_clmm<T0, T1>(arg0, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, arg3, arg5, arg6, arg7)
        } else {
            assert!(arg1 == 4, 201);
            swap_on_deepbook_v3<T0, T1>(arg0, @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d, arg3, arg5, arg6, arg7)
        };
        let v1 = if (arg2 == 2) {
            swap_on_cetus_clmm<T1, T0>(v0, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, arg4, arg5, arg6, arg7)
        } else if (arg2 == 3) {
            swap_on_turbos_clmm<T1, T0>(v0, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, arg4, arg5, arg6, arg7)
        } else {
            assert!(arg2 == 4, 201);
            swap_on_deepbook_v3<T1, T0>(v0, @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d, arg4, arg5, arg6, arg7)
        };
        let v2 = v1;
        assert!(0x2::coin::value<T0>(&v2) > 0x2::coin::value<T0>(&arg0), 202);
        v2
    }

    public fun get_dex_fee_bps(arg0: u8) : u64 {
        if (arg0 == 2) {
            25
        } else if (arg0 == 3) {
            30
        } else if (arg0 == 4) {
            10
        } else if (arg0 == 5) {
            25
        } else if (arg0 == 1) {
            30
        } else if (arg0 == 6) {
            25
        } else {
            50
        }
    }

    public fun get_pool_liquidity(arg0: address, arg1: u8) : u64 {
        if (arg1 == 2) {
            50000000000
        } else if (arg1 == 3) {
            30000000000
        } else if (arg1 == 4) {
            20000000000
        } else if (arg1 == 5) {
            15000000000
        } else {
            5000000000
        }
    }

    public entry fun initialize_dex_config(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DexIntegrationConfig{
            id                      : 0x2::object::new(arg3),
            enabled_dexes           : arg0,
            min_liquidity_threshold : arg1,
            max_slippage_bps        : arg2,
            owner                   : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<DexIntegrationConfig>(v0);
    }

    public fun is_dex_operational(arg0: u8, arg1: u64) : bool {
        get_pool_liquidity(@0x0, arg0) >= arg1
    }

    public fun swap_on_cetus_clmm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 204);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 * 25 / 10000;
        let v2 = v0 - v1;
        assert!(v2 >= arg2, 203);
        let v3 = SwapExecuted{
            dex_id       : 2,
            pool_address : arg1,
            amount_in    : v0,
            amount_out   : v2,
            fee_paid     : v1,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SwapExecuted>(v3);
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    public fun swap_on_deepbook_v3<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 204);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 * 10 / 10000;
        let v2 = v0 - v1;
        assert!(v2 >= arg2, 203);
        let v3 = SwapExecuted{
            dex_id       : 4,
            pool_address : arg1,
            amount_in    : v0,
            amount_out   : v2,
            fee_paid     : v1,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SwapExecuted>(v3);
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    public fun swap_on_turbos_clmm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 204);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 * 30 / 10000;
        let v2 = v0 - v1;
        assert!(v2 >= arg2, 203);
        let v3 = SwapExecuted{
            dex_id       : 3,
            pool_address : arg1,
            amount_in    : v0,
            amount_out   : v2,
            fee_paid     : v1,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SwapExecuted>(v3);
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    // decompiled from Move bytecode v6
}

