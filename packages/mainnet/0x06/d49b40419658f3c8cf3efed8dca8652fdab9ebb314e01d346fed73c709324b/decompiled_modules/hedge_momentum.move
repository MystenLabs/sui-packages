module 0x107fa8ce20f180eafed556b4592af8c8c244d651a9a8030612d4f690ff7d6ebe::hedge_momentum {
    struct HEDGE_MOMENTUM has drop {
        dummy_field: bool,
    }

    struct VERSION has copy, drop, store {
        dummy_field: bool,
    }

    struct SwapBalance<phantom T0, phantom T1> has store {
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    public fun calculate_rebalance_amount<T0, T1, T2>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>) : (u64, u64) {
        let v0 = arg0 * arg3 > arg1 * arg2;
        let v1 = if (v0) {
            let _ = (arg0 - (((arg1 as u128) * (arg2 as u128) / (arg3 as u128)) as u64)) / 2;
            ((((arg0 as u128) * (arg3 as u128) / (arg2 as u128)) as u64) - arg1) / 2
        } else {
            let _ = ((((arg1 as u128) * (arg2 as u128) / (arg3 as u128)) as u64) - arg0) / 2;
            (arg1 - (((arg0 as u128) * (arg3 as u128) / (arg2 as u128)) as u64)) / 2
        };
        let v3 = v1;
        let (v4, v5) = if (v0) {
            (0x1::type_name::get<T0>() == 0x1::type_name::get<T1>(), false)
        } else {
            (0x1::type_name::get<T0>() == 0x1::type_name::get<T2>(), true)
        };
        let v6 = if (v4) {
            4295048017
        } else {
            79226673515401279992447579050
        };
        let v7 = 0;
        while (v7 < 1000) {
            let v8 = calculate_swap_result<T1, T2>(arg4, v4, v5, v3, v6);
            let (v9, v10) = if (v0) {
                let v10 = arg1 + v3;
                (arg0 - v8, v10)
            } else {
                let v10 = v3 - arg1;
                (v8 + arg0, v10)
            };
            let v11 = (((v9 as u128) * (arg3 as u128) / (arg2 as u128)) as u64);
            if (v11 == v10) {
                return (v8, v3)
            };
            let v12 = if (v11 > v10) {
                v11 - v10
            } else {
                v10 - v11
            };
            let v13 = if (v3 > 10000) {
                v3 / 100
            } else if (v3 > 1000) {
                v3 / 10
            } else if (v3 > 100) {
                10
            } else {
                1
            };
            let v14 = v3 + v13;
            let v15 = if (v3 > v13) {
                v3 - v13
            } else {
                0
            };
            let (v16, v17) = if (v0) {
                (arg0 - calculate_swap_result<T1, T2>(arg4, v4, v5, v14, v6), arg1 + v14)
            } else {
                (calculate_swap_result<T1, T2>(arg4, v4, v5, v14, v6) + arg0, v14 - arg1)
            };
            let v18 = (((v16 as u128) * (arg3 as u128) / (arg2 as u128)) as u64);
            let v19 = if (v18 > v17) {
                v18 - v17
            } else {
                v17 - v18
            };
            let (v20, v21) = if (v0) {
                (arg0 - calculate_swap_result<T1, T2>(arg4, v4, v5, v15, v6), arg1 + v15)
            } else {
                (calculate_swap_result<T1, T2>(arg4, v4, v5, v15, v6) + arg0, v15 - arg1)
            };
            let v22 = (((v20 as u128) * (arg3 as u128) / (arg2 as u128)) as u64);
            let v23 = if (v22 > v21) {
                v22 - v21
            } else {
                v21 - v22
            };
            if (v19 == v23) {
                let v24 = if (v11 > v10) {
                    if (v0 && v3 > 1) {
                        v3 - 1
                    } else {
                        v3 + 1
                    }
                } else if (v0) {
                    v3 + 1
                } else if (v3 > 1) {
                    v3 - 1
                } else {
                    0
                };
                v3 = v24;
                continue
            };
            let v25 = if (v12 > 1000) {
                v12 / 10
            } else if (v12 > 100) {
                v12 / 2
            } else {
                v12
            };
            if (v11 > v10) {
                v3 = v3 + v25;
            } else {
                v3 = v3 - v25;
            };
            v7 = v7 + 1;
        };
        abort 999
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : u64 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, arg2, arg4, arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0)
    }

    // decompiled from Move bytecode v6
}

