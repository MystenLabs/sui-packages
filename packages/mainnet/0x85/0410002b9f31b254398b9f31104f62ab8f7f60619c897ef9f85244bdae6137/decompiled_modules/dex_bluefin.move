module 0x850410002b9f31b254398b9f31104f62ab8f7f60619c897ef9f85244bdae6137::dex_bluefin {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_base: 0x2::balance::Balance<T0>,
        reserve_quote: 0x2::balance::Balance<T1>,
        fee_rate: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg0.reserve_base, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_quote, 0x2::coin::into_balance<T1>(arg2));
    }

    fun calculate_output_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 4);
        assert!(arg1 > 0 && arg2 > 0, 2);
        let v0 = arg0 * (10000 - arg3);
        v0 * arg2 / (arg1 * 10000 + v0)
    }

    public fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        Pool<T0, T1>{
            id            : 0x2::object::new(arg0),
            reserve_base  : 0x2::balance::zero<T0>(),
            reserve_quote : 0x2::balance::zero<T1>(),
            fee_rate      : 20,
        }
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = calculate_output_amount(0x2::coin::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.reserve_base), 0x2::balance::value<T1>(&arg0.reserve_quote), arg0.fee_rate);
        assert!(v0 >= arg2, 3);
        0x2::balance::join<T0>(&mut arg0.reserve_base, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_quote, v0), arg4)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = calculate_output_amount(0x2::coin::value<T1>(&arg1), 0x2::balance::value<T1>(&arg0.reserve_quote), 0x2::balance::value<T0>(&arg0.reserve_base), arg0.fee_rate);
        assert!(v0 >= arg2, 3);
        0x2::balance::join<T1>(&mut arg0.reserve_quote, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_base, v0), arg4)
    }

    // decompiled from Move bytecode v6
}

