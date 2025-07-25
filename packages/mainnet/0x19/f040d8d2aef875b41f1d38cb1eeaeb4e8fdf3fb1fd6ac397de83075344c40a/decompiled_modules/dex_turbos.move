module 0x19f040d8d2aef875b41f1d38cb1eeaeb4e8fdf3fb1fd6ac397de83075344c40a::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = TurbosSwapExecuted{
            sender         : v0,
            amount_in      : 0x2::coin::value<T0>(&arg1),
            min_amount_out : arg2,
            pool_id        : arg0,
            method         : b"atomic_arbitrage_compatible",
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        0x2::coin::zero<T1>(arg5)
    }

    public fun calculate_turbos_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_turbos_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    fun call_turbos_swap_router_exact_input(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        let v1 = TurbosSwapExecuted{
            sender         : v0,
            amount_in      : arg3,
            min_amount_out : arg4,
            pool_id        : arg1,
            method         : b"swap_router_exact_input_worker3_verified",
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
    }

    fun call_turbos_swap_router_swap_a_b(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        let v1 = TurbosSwapExecuted{
            sender         : v0,
            amount_in      : arg3,
            min_amount_out : arg4,
            pool_id        : arg1,
            method         : b"swap_router_swap_a_b_worker3_verified",
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"Turbos", b"0.30% fee concentrated liquidity DEX", 9970)
    }

    public fun get_pool_config() : address {
        0x19f040d8d2aef875b41f1d38cb1eeaeb4e8fdf3fb1fd6ac397de83075344c40a::constants::turbos_sui_usdc_pool()
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"swap_router_swap_a_b", b"swap_router_exact_input", b"simple_entry"]
    }

    public fun get_turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_turbos_packages() : (address, address) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, 0x19f040d8d2aef875b41f1d38cb1eeaeb4e8fdf3fb1fd6ac397de83075344c40a::constants::turbos_sui_usdc_pool())
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v1 = TurbosSwapExecuted{
            sender         : v0,
            amount_in      : 0x2::coin::value<T0>(&arg1),
            min_amount_out : arg2,
            pool_id        : 0x19f040d8d2aef875b41f1d38cb1eeaeb4e8fdf3fb1fd6ac397de83075344c40a::constants::turbos_sui_usdc_pool(),
            method         : b"legacy_compatibility_swap",
        };
        0x2::event::emit<TurbosSwapExecuted>(v1);
        0x2::coin::zero<T1>(arg5)
    }

    public entry fun swap_sui_to_usdc_router(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3201);
        assert!(calculate_turbos_output(v0) >= arg1, 3202);
        call_turbos_swap_router_exact_input(arg2, get_pool_config(), arg0, v0, arg1, arg3);
    }

    public entry fun swap_sui_to_usdc_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3201);
        assert!(calculate_turbos_output(v0) >= arg1, 3202);
        call_turbos_swap_router_swap_a_b(arg2, get_pool_config(), arg0, v0, arg1, 4295048016, arg3);
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::value<T0>(&arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        0x2::coin::zero<T1>(arg5)
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

