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
        let (v1, v2) = if (v0) {
            ((arg0 - (((arg1 as u128) * (arg2 as u128) / (arg3 as u128)) as u64)) / 2, ((((arg0 as u128) * (arg3 as u128) / (arg2 as u128)) as u64) - arg1) / 2)
        } else {
            (((((arg1 as u128) * (arg2 as u128) / (arg3 as u128)) as u64) - arg0) / 2, (arg1 - (((arg0 as u128) * (arg3 as u128) / (arg2 as u128)) as u64)) / 2)
        };
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = if (v0) {
            (0x1::type_name::get<T0>() == 0x1::type_name::get<T1>(), false)
        } else {
            (0x1::type_name::get<T0>() == 0x1::type_name::get<T2>(), true)
        };
        let v7 = if (v5) {
            4295048017
        } else {
            79226673515401279992447579050
        };
        let v8 = 0;
        while (v8 < 1000) {
            let v9 = calculate_swap_result<T1, T2>(arg4, v5, v6, v3, v7);
            v4 = v9;
            let (v10, v11) = if (v0) {
                let v11 = arg1 + v3;
                (arg0 - v9, v11)
            } else {
                let v11 = v3 - arg1;
                (v9 + arg0, v11)
            };
            let v12 = (((v10 as u128) * (arg3 as u128) / (arg2 as u128)) as u64);
            if (v12 == v11) {
                return (v9, v3)
            };
            let v13 = if (v12 > v11) {
                v12 - v11
            } else {
                v11 - v12
            };
            let v14 = if (v3 > 10000) {
                v3 / 100
            } else if (v3 > 1000) {
                v3 / 10
            } else if (v3 > 100) {
                10
            } else {
                1
            };
            let v15 = v3 + v14;
            let v16 = if (v3 > v14) {
                v3 - v14
            } else {
                0
            };
            let (v17, v18) = if (v0) {
                (arg0 - calculate_swap_result<T1, T2>(arg4, v5, v6, v15, v7), arg1 + v15)
            } else {
                (calculate_swap_result<T1, T2>(arg4, v5, v6, v15, v7) + arg0, v15 - arg1)
            };
            let v19 = (((v17 as u128) * (arg3 as u128) / (arg2 as u128)) as u64);
            let v20 = if (v19 > v18) {
                v19 - v18
            } else {
                v18 - v19
            };
            let (v21, v22) = if (v0) {
                (arg0 - calculate_swap_result<T1, T2>(arg4, v5, v6, v16, v7), arg1 + v16)
            } else {
                (calculate_swap_result<T1, T2>(arg4, v5, v6, v16, v7) + arg0, v16 - arg1)
            };
            let v23 = (((v21 as u128) * (arg3 as u128) / (arg2 as u128)) as u64);
            let v24 = if (v23 > v22) {
                v23 - v22
            } else {
                v22 - v23
            };
            if (v20 == v24) {
                let v25 = if (v12 > v11) {
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
                v3 = v25;
                continue
            };
            let v26 = if (v13 > 1000) {
                v13 / 10
            } else if (v13 > 100) {
                v13 / 2
            } else {
                v13
            };
            if (v12 > v11) {
                v3 = v3 + v26;
            } else {
                v3 = v3 - v26;
            };
            v8 = v8 + 1;
        };
        (v4, v3)
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : u64 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, arg2, arg4, arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0)
    }

    // decompiled from Move bytecode v6
}

