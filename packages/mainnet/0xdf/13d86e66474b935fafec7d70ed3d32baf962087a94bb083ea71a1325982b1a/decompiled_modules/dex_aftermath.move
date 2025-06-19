module 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        amount_out: u64,
        min_amount_out: u64,
        pool_id: address,
        token_in_type: vector<u8>,
        token_out_type: vector<u8>,
        swap_direction: u8,
        package: address,
    }

    struct CFMMPoolOperation has copy, drop {
        pool_id: address,
        operation_type: vector<u8>,
        amounts: vector<u64>,
        fees_paid: u64,
        timestamp: u64,
    }

    fun aftermath_get_pool_quote(arg0: address, arg1: u64) : u64 {
        (arg1 - arg1 * 30 / 10000) * 2760 / 1000000
    }

    fun aftermath_get_pool_reserves(arg0: address) : (u64, u64) {
        (1000000000000, 2760000000)
    }

    fun aftermath_get_supported_pools() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x7903f6ab51fba9f9f88d78a77f1d5d1ae3b73f6515c3d4e7a4c7b56b8c22c3e7);
        v0
    }

    fun calculate_aftermath_fees(arg0: u64) : u64 {
        arg0 * 30 / 10000
    }

    fun estimate_cfmm_output(arg0: u64, arg1: address) : u64 {
        aftermath_get_pool_quote(arg1, arg0)
    }

    fun execute_aftermath_cfmm_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 != @0x0, 7003);
        let v0 = execute_cfmm_pool_swap<T0, T1>(0x2::coin::into_balance<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::coin::from_balance<T1>(v0, arg5);
        let v2 = 0x2::coin::value<T1>(&v1);
        assert!(v2 >= arg3, 7002);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg2);
        0x1::vector::push_back<u64>(v4, v2);
        let v5 = CFMMPoolOperation{
            pool_id        : arg1,
            operation_type : b"swap_exact_in",
            amounts        : v3,
            fees_paid      : calculate_aftermath_fees(arg2),
            timestamp      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CFMMPoolOperation>(v5);
        v1
    }

    fun execute_cfmm_pool_swap<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg5), 0x2::tx_context::sender(arg5));
        abort 0
    }

    public fun get_aftermath_package() : address {
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::aftermath_package()
    }

    public fun get_pool_liquidity(arg0: address) : (u64, u64) {
        assert!(arg0 != @0x0, 7003);
        aftermath_get_pool_reserves(arg0)
    }

    public fun get_sui_to_usdc_quote(arg0: u64, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 > 0, 7005);
        assert!(arg1 != @0x0, 7003);
        estimate_cfmm_output(arg0, arg1)
    }

    public fun get_supported_pools() : vector<address> {
        aftermath_get_supported_pools()
    }

    public fun get_usdc_to_sui_quote(arg0: u64, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 > 0, 7005);
        assert!(arg1 != @0x0, 7003);
        estimate_cfmm_output(arg0, arg1)
    }

    public fun is_pool_supported(arg0: address) : bool {
        arg0 != @0x0
    }

    public entry fun swap_sui_to_usdc<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 7001);
        assert!(arg2 > 0, 7001);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = execute_aftermath_cfmm_swap<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4);
        let v3 = AftermathSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            amount_out     : 0x2::coin::value<T1>(&v2),
            min_amount_out : arg2,
            pool_id        : arg1,
            token_in_type  : b"SUI",
            token_out_type : b"USDC",
            swap_direction : 0,
            package        : 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::aftermath_package(),
        };
        0x2::event::emit<AftermathSwapExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v1);
    }

    public entry fun swap_usdc_to_sui<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 7001);
        assert!(arg2 > 0, 7001);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = execute_aftermath_cfmm_swap<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4);
        let v3 = AftermathSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            amount_out     : 0x2::coin::value<T1>(&v2),
            min_amount_out : arg2,
            pool_id        : arg1,
            token_in_type  : b"USDC",
            token_out_type : b"SUI",
            swap_direction : 1,
            package        : 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::constants::aftermath_package(),
        };
        0x2::event::emit<AftermathSwapExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v1);
    }

    public fun validate_slippage(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return false
        };
        let v0 = estimate_cfmm_output(arg0, @0x1234567890abcdef1234567890abcdef12345678);
        if (v0 == 0) {
            return false
        };
        let v1 = if (v0 > arg1) {
            (v0 - arg1) * 10000 / v0
        } else {
            0
        };
        v1 <= arg2
    }

    // decompiled from Move bytecode v6
}

