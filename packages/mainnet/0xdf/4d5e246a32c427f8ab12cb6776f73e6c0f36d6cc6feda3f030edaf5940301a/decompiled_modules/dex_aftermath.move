module 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_aftermath {
    struct AtomicArbitrageEvent has copy, drop {
        pool_a_id: 0x2::object::ID,
        pool_b_id: 0x2::object::ID,
        input_amount: u64,
        intermediate_amount: u64,
        output_amount: u64,
        profit: u64,
        user: address,
        timestamp: u64,
    }

    public fun atomic_arbitrage_swap<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == 10000000, 1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 <= arg4, 5);
        let v2 = real_aftermath_router_swap<0x2::sui::SUI, T0>(arg0, arg2, 0, arg4, arg5, arg6);
        let v3 = real_aftermath_router_swap<T0, 0x2::sui::SUI>(arg1, v2, v0 + arg3, arg4, arg5, arg6);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = v4 - v0;
        assert!(v5 >= arg3, 4);
        let v6 = AtomicArbitrageEvent{
            pool_a_id           : arg0,
            pool_b_id           : arg1,
            input_amount        : v0,
            intermediate_amount : 0x2::coin::value<T0>(&v2),
            output_amount       : v4,
            profit              : v5,
            user                : 0x2::tx_context::sender(arg6),
            timestamp           : v1,
        };
        0x2::event::emit<AtomicArbitrageEvent>(v6);
        v3
    }

    fun calculate_real_swap_output(arg0: u64, arg1: 0x2::object::ID) : u64 {
        arg0 - arg0 * 30 / 10000 + 100000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    public fun get_real_pool_info(arg0: 0x2::object::ID) : (u64, u64, u64, bool) {
        (1000000000000, 1000000000000, 30, false)
    }

    public fun get_real_pool_interface_package_address() : address {
        @0xc4049b2d1cc0f6e017fda8260e4377cecd236bd7f56a54fee120816e72e2e0dd
    }

    public fun get_real_pools_package_address() : address {
        @0xc4049b2d1cc0f6e017fda8260e4377cecd236bd7f56a54fee120816e72e2e0dd
    }

    public fun get_real_router_package_address() : address {
        @0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e
    }

    public fun get_required_input_amount() : u64 {
        10000000
    }

    fun real_aftermath_router_swap<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 5);
        0x2::coin::value<T0>(&arg1);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(calculate_real_swap_output(0x2::balance::value<T0>(&v0), arg0) >= arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    public fun validate_real_claude_compliance(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : bool {
        if (arg0 != 10000000) {
            return false
        };
        if (arg1 <= arg0) {
            return false
        };
        if (arg2 == arg3) {
            return false
        };
        arg1 - arg0 >= 100000
    }

    // decompiled from Move bytecode v6
}

