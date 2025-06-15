module 0x2560e4e75a3dd4bdbd4841bbb25197fb3695b59c8ee4aa9dfef14a0d02cbef24::dex_cetus {
    struct CetusSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        sqrt_price_after: u128,
    }

    struct CetusSwapCoordination has copy, drop {
        package: address,
        dex_module: vector<u8>,
        function: vector<u8>,
        global_config: address,
        pool: address,
        amount_in: u64,
        min_amount_out: u64,
        sqrt_price_limit: u128,
        sender: address,
        instruction: vector<u8>,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(is_valid_pool(arg0), 601);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 602);
        assert!(v0 <= 1000000000000000, 605);
        let (v1, v2) = get_quote_with_security_checks(arg0, v0, true);
        assert!(v1 >= arg2, 603);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = CetusSwapCoordination{
            package          : @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3,
            dex_module       : b"pool_script",
            function         : b"swap_a2b_with_security_checks",
            global_config    : @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f,
            pool             : arg0,
            amount_in        : v0,
            min_amount_out   : arg2,
            sqrt_price_limit : calculate_secure_sqrt_price_limit(arg0, v0),
            sender           : v3,
            instruction      : b"EXECUTE_SECURE_CETUS_SWAP_POST_MAY2025",
        };
        0x2::event::emit<CetusSwapCoordination>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v3);
        let v5 = CetusSwapExecuted{
            pool             : arg0,
            amount_in        : v0,
            amount_out       : v1,
            fee_amount       : v2,
            sqrt_price_after : calculate_secure_sqrt_price_limit(arg0, v0),
        };
        0x2::event::emit<CetusSwapExecuted>(v5);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    fun calculate_price_impact(arg0: u64, arg1: address) : u64 {
        calculate_secure_price_impact(arg0, arg1)
    }

    fun calculate_secure_price_impact(arg0: u64, arg1: address) : u64 {
        assert!(is_valid_pool(arg1), 601);
        if (arg0 > 100000000000) {
            abort 608
        };
        if (arg0 > 10000000000) {
            150
        } else if (arg0 > 1000000000) {
            50
        } else {
            10
        }
    }

    fun calculate_secure_sqrt_price_limit(arg0: address, arg1: u64) : u128 {
        assert!(is_valid_pool(arg0), 601);
        assert!(arg1 > 0 && arg1 <= 1000000000000000, 605);
        if (arg1 > 1000000000) {
            4295048016 / 2
        } else {
            4295048016
        }
    }

    public fun calculate_sqrt_price_limit(arg0: u64, arg1: bool, arg2: u64) : u128 {
        if (arg1) {
        };
        18446744073709551616
    }

    fun checked_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 605);
        assert!(arg0 <= 18446744073709551615 / arg1, 605);
        let v0 = arg0 * arg1 / arg2;
        assert!(v0 <= arg0, 605);
        v0
    }

    public fun get_global_config() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_integrate_package() : address {
        @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3
    }

    public fun get_pool_fee(arg0: address) : u64 {
        if (arg0 == @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3) {
            25
        } else if (arg0 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630) {
            25
        } else {
            30
        }
    }

    public fun get_pool_script_package() : address {
        @0x2eeaab737b37137b94bfa8f841f92e36a153641119da3456dec1926b9960d9be
    }

    public fun get_quote(arg0: address, arg1: u64, arg2: bool) : (u64, u64) {
        get_quote_with_security_checks(arg0, arg1, arg2)
    }

    public fun get_quote_with_security_checks(arg0: address, arg1: u64, arg2: bool) : (u64, u64) {
        assert!(arg1 > 0, 602);
        assert!(arg1 <= 1000000000000000, 605);
        let v0 = checked_mul_div(arg1, get_pool_fee(arg0), 10000);
        assert!(v0 <= arg1, 605);
        let v1 = arg1 - v0;
        let v2 = checked_mul_div(v1, calculate_secure_price_impact(arg1, arg0), 10000);
        assert!(v2 <= v1, 606);
        let v3 = v1 - v2;
        assert!(v3 > 0, 606);
        (v3, v0)
    }

    public fun get_sui_usdt_pool() : address {
        @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3
    }

    public fun get_swap_params(arg0: address) : (u64, u64, bool) {
        if (arg0 == @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3) {
            (2500, 50, true)
        } else if (arg0 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630) {
            (2500, 50, true)
        } else {
            (3000, 60, true)
        }
    }

    fun is_valid_pool(arg0: address) : bool {
        arg0 == @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3 || arg0 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public entry fun swap_sui_to_usdt(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = CetusSwapCoordination{
            package          : @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3,
            dex_module       : b"pool_script",
            function         : b"swap_b2a",
            global_config    : @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f,
            pool             : @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3,
            amount_in        : v0,
            min_amount_out   : arg1,
            sqrt_price_limit : 4295048016,
            sender           : v1,
            instruction      : b"EXECUTE_SUI_TO_USDT_SWAP",
        };
        0x2::event::emit<CetusSwapCoordination>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public entry fun swap_usdt_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 602);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = CetusSwapCoordination{
            package          : @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3,
            dex_module       : b"pool_script",
            function         : b"swap_a2b",
            global_config    : @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f,
            pool             : @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3,
            amount_in        : v0,
            min_amount_out   : arg1,
            sqrt_price_limit : 4295048016,
            sender           : v1,
            instruction      : b"EXECUTE_USDT_TO_SUI_SWAP",
        };
        0x2::event::emit<CetusSwapCoordination>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
    }

    public fun test_function() : u64 {
        42
    }

    // decompiled from Move bytecode v6
}

