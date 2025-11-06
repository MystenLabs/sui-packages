module 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::multi_dex_router {
    struct RouteStep has copy, drop {
        dex_id: u8,
        fee_tier: u64,
        min_output: u64,
    }

    public fun arbitrage_2_hop<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u8, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = route_swap_a_b<T0, T1>(arg0, arg1, 0, arg4);
        let v1 = route_swap_b_a<T0, T1>(v0, arg2, 0, arg4);
        0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::validate_arbitrage(0x2::balance::value<T0>(&arg0), 0x2::balance::value<T0>(&v1), arg3);
        v1
    }

    public fun arbitrage_3_hop<T0, T1, T2>(arg0: 0x2::balance::Balance<T0>, arg1: u8, arg2: u8, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        0x2::balance::destroy_zero<T0>(arg0);
        0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::validate_arbitrage(v0, v0 * 990 / 1000, arg4);
        0x2::balance::zero<T0>()
    }

    public fun compare_all_dexes<T0, T1>() : vector<u64> {
        vector[1000000, 1001000, 999500, 1000500]
    }

    public fun find_best_route<T0, T1>(arg0: u64, arg1: &0x2::tx_context::TxContext) : (u8, u64) {
        (1, arg0 * 997 / 1000)
    }

    fun route_swap_a_b<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (arg1 == 1) {
            0x2::balance::destroy_zero<T0>(arg0);
            0x2::balance::zero<T1>()
        } else if (arg1 == 2) {
            0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::turbos_integration::swap_turbos_a_b<T0, T1, T0>(arg0, arg2, arg3)
        } else if (arg1 == 3) {
            0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::kriya_integration::swap_kriya_a_b<T0, T1>(arg0, arg2, arg3)
        } else {
            assert!(arg1 == 4, 200);
            0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::deepbook_integration::swap_deepbook_a_b<T0, T1>(arg0, arg2, arg3)
        }
    }

    fun route_swap_b_a<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (arg1 == 1) {
            0x2::balance::destroy_zero<T1>(arg0);
            0x2::balance::zero<T0>()
        } else if (arg1 == 2) {
            0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::turbos_integration::swap_turbos_b_a<T0, T1, T0>(arg0, arg2, arg3)
        } else if (arg1 == 3) {
            0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::kriya_integration::swap_kriya_b_a<T0, T1>(arg0, arg2, arg3)
        } else {
            assert!(arg1 == 4, 200);
            0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::deepbook_integration::swap_deepbook_b_a<T0, T1>(arg0, arg2, arg3)
        }
    }

    // decompiled from Move bytecode v6
}

