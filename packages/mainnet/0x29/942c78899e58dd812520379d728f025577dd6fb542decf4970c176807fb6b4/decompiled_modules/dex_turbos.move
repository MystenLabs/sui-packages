module 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_turbos_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_turbos_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    fun call_turbos_swap_exact_input<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::tx_context::sender(arg7);
        turbos_internal_swap_logic<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun call_turbos_swap_exact_output<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg7));
        0x2::coin::zero<T1>(arg7)
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"Turbos", b"0.30% fee concentrated liquidity DEX", 9970)
    }

    public fun get_pool_config() : address {
        0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::turbos_sui_usdc_pool()
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"swap_sui_to_usdc", b"swap_usdc_to_sui", b"swap_entry"]
    }

    public fun get_turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_turbos_packages() : (address, address) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::constants::turbos_sui_usdc_pool())
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3201);
        assert!(arg0 != @0x0, 3203);
        assert!(calculate_turbos_output(v0) >= arg2, 3202);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        let v1 = TurbosSwapExecuted{
            sender         : 0x2::tx_context::sender(arg6),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"swap_sui_to_usdc",
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
        0x2::coin::zero<T1>(arg6)
    }

    public entry fun swap_sui_to_usdc_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3201);
        assert!(calculate_turbos_output(v0) >= arg1, 3202);
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        let v2 = TurbosSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg1,
            pool_id        : get_pool_config(),
            method         : b"swap_entry",
        };
        0x2::event::emit<TurbosSwapExecuted>(v2);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3201);
        assert!(arg0 != @0x0, 3203);
        assert!(calculate_turbos_usdc_to_sui_output(v0) >= arg2, 3202);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        let v1 = TurbosSwapExecuted{
            sender         : 0x2::tx_context::sender(arg6),
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"swap_usdc_to_sui",
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
        0x2::coin::zero<T1>(arg6)
    }

    fun turbos_internal_swap_logic<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(calculate_turbos_output(arg3) >= arg4, 3202);
        let v1 = if (0x2::coin::value<T0>(&arg2) > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
            0x2::coin::split<T0>(&mut arg2, arg3, arg7)
        } else {
            arg2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, @0x0);
        let v2 = TurbosSwapExecuted{
            sender         : v0,
            amount_in      : arg3,
            min_amount_out : arg4,
            pool_id        : arg1,
            method         : b"internal_swap_logic",
        };
        0x2::event::emit<TurbosSwapExecuted>(v2);
        0x2::coin::zero<T1>(arg7)
    }

    public fun validate_swap_params(arg0: u64, arg1: u64) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg0 >= 1000000
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

