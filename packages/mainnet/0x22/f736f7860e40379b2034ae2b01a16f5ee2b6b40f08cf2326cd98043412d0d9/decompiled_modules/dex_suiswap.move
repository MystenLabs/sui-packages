module 0x22f736f7860e40379b2034ae2b01a16f5ee2b6b40f08cf2326cd98043412d0d9::dex_suiswap {
    struct SuiSwapSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_suiswap_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_suiswap_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    fun call_suiswap_router_swap(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = SuiSwapSwapExecuted{
            sender         : v0,
            amount_in      : arg2,
            min_amount_out : arg3,
            pool_id        : get_suiswap_pool(),
            method         : b"router_swap",
        };
        0x2::event::emit<SuiSwapSwapExecuted>(v1);
    }

    fun call_suiswap_swap_exact_input(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = SuiSwapSwapExecuted{
            sender         : v0,
            amount_in      : arg3,
            min_amount_out : arg4,
            pool_id        : arg2,
            method         : b"swap_exact_input",
        };
        0x2::event::emit<SuiSwapSwapExecuted>(v1);
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"SuiSwap", b"0.30% fee AMM DEX", 9970)
    }

    public fun get_suiswap_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_suiswap_packages() : (address, address) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, get_suiswap_pool())
    }

    public fun get_suiswap_pool() : address {
        @0x0
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"swap_exact_input", b"router_swap"]
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v1 = SuiSwapSwapExecuted{
            sender         : v0,
            amount_in      : 0x2::coin::value<T0>(&arg1),
            min_amount_out : arg2,
            pool_id        : get_suiswap_pool(),
            method         : b"legacy_compatibility_swap",
        };
        0x2::event::emit<SuiSwapSwapExecuted>(v1);
        0x2::coin::zero<T1>(arg4)
    }

    public entry fun swap_sui_to_usdc_router(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3601);
        assert!(calculate_suiswap_output(v0) >= arg1, 3602);
        call_suiswap_router_swap(arg2, arg0, v0, arg1, arg3);
    }

    public entry fun swap_sui_to_usdc_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3601);
        assert!(calculate_suiswap_output(v0) >= arg1, 3602);
        call_suiswap_swap_exact_input(arg2, arg0, get_suiswap_pool(), v0, arg1, arg3);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::coin::zero<T1>(arg4)
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

