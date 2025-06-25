module 0x762b40b0604ed2fd777d908dee19562ff5d28fee3132fea3ebcd1053cf390b95::dex_aftermath {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        amplification_factor: u64,
        swap_fee: u64,
        admin_fee: u64,
        virtual_price: u128,
        pool_invariant: u128,
        is_stable_pool: bool,
    }

    fun calculate_d(arg0: u64, arg1: u64, arg2: u64) : u128 {
        let v0 = ((arg0 + arg1) as u128);
        v0 * (arg2 as u128) * 2 + 2 * (arg0 as u128) * (arg1 as u128) / v0
    }

    fun calculate_stable_swap_output<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance_a);
        let v1 = 0x2::balance::value<T1>(&arg0.balance_b);
        let v2 = arg0.amplification_factor;
        if (arg2) {
            let v4 = calculate_y(v0 + arg1, calculate_d(v0, v1, v2), v2);
            if (v4 < v1) {
                v1 - v4
            } else {
                0
            }
        } else {
            let v5 = calculate_y(v1 + arg1, calculate_d(v0, v1, v2), v2);
            if (v5 < v0) {
                v0 - v5
            } else {
                0
            }
        }
    }

    fun calculate_standard_swap_output<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            let v1 = (arg1 as u128);
            ((v1 * (0x2::balance::value<T1>(&arg0.balance_b) as u128) / ((0x2::balance::value<T0>(&arg0.balance_a) as u128) + v1)) as u64)
        } else {
            let v2 = (arg1 as u128);
            ((v2 * (0x2::balance::value<T0>(&arg0.balance_a) as u128) / ((0x2::balance::value<T1>(&arg0.balance_b) as u128) + v2)) as u64)
        }
    }

    fun calculate_y(arg0: u64, arg1: u128, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((arg1 - v0) as u64)
    }

    public fun get_pool_params<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, bool, u128) {
        (arg0.amplification_factor, arg0.swap_fee, arg0.is_stable_pool, arg0.pool_invariant)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 3);
        let v0 = if (arg0.is_stable_pool) {
            calculate_stable_swap_output<T0, T1>(arg0, arg2, true)
        } else {
            calculate_standard_swap_output<T0, T1>(arg0, arg2, true)
        };
        assert!(v0 >= arg3, 2);
        assert!(v0 < 0x2::balance::value<T1>(&arg0.balance_b), 1);
        let v1 = v0 * arg0.swap_fee / 10000;
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        let v2 = 0x2::balance::split<T1>(&mut arg0.balance_b, v0 - v1);
        update_invariant<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        let v0 = if (arg0.is_stable_pool) {
            calculate_stable_swap_output<T0, T1>(arg0, arg2, false)
        } else {
            calculate_standard_swap_output<T0, T1>(arg0, arg2, false)
        };
        assert!(v0 >= arg3, 2);
        assert!(v0 < 0x2::balance::value<T0>(&arg0.balance_a), 1);
        let v1 = v0 * arg0.swap_fee / 10000;
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        let v2 = 0x2::balance::split<T0>(&mut arg0.balance_a, v0 - v1);
        update_invariant<T0, T1>(arg0);
        0x2::coin::from_balance<T0>(v2, arg5)
    }

    fun update_invariant<T0, T1>(arg0: &mut Pool<T0, T1>) {
        if (arg0.is_stable_pool) {
            arg0.pool_invariant = calculate_d(0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), arg0.amplification_factor);
        } else {
            arg0.pool_invariant = (0x2::balance::value<T0>(&arg0.balance_a) as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128);
        };
    }

    // decompiled from Move bytecode v6
}

