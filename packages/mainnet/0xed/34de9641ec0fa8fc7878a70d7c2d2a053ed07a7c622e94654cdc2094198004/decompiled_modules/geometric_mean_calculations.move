module 0x880182bc2d65686b6f144f1af676e1a0d8cdd4dbf6e76309bf24befd2e91c6a3::geometric_mean_calculations {
    public fun calc_all_coin_deposit(arg0: &vector<u128>, arg1: &vector<u128>) : u64 {
        let v0 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg0)) {
            let v3 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down((*0x1::vector::borrow<u128>(arg1, v2) as u256), (*0x1::vector::borrow<u128>(arg0, v2) as u256));
            if (v3 < v0) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        (v1 as u64)
    }

    public fun calc_all_coin_withdraw(arg0: &vector<u128>, arg1: &vector<u128>) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg0)) {
            let v3 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down((*0x1::vector::borrow<u128>(arg1, v2) as u256), (*0x1::vector::borrow<u128>(arg0, v2) as u256));
            if (v3 > v0) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        (v1 as u64)
    }

    public fun calc_deposit_fixed_amounts(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128) : u64 {
        assert!(arg5 < (1000000000000000000 as u128), 5);
        let v0 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down((calc_deposit_fixed_amounts_direct(arg0, arg1, arg2, arg3, arg4) as u256), (arg5 as u256));
        assert!(v0 <= 18446744073709551615, 9);
        assert!(v0 >= 54210108624275221, 10);
        (v0 as u64)
    }

    public fun calc_deposit_fixed_amounts_direct(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>) : u64 {
        let v0 = 0x1::vector::length<u128>(arg0);
        let v1 = calc_invariant_full(arg0, arg1);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 1000000000000000000;
        let v6 = v5;
        let v7 = 0;
        let v8 = 0;
        while (v8 < v0) {
            let v9 = (*0x1::vector::borrow<u128>(arg0, v8) as u256);
            let v10 = (*0x1::vector::borrow<u128>(arg4, v8) as u256);
            assert!(*0x1::vector::borrow<u64>(arg2, v8) != 1000000000000000000 && *0x1::vector::borrow<u64>(arg3, v8) != 1000000000000000000, 4);
            v7 = v7 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v8) as u256), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v9 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg2, v8) as u256)), v10)));
            let v11 = (*0x1::vector::borrow<u64>(arg3, v8) as u256) * v9 / (v9 + v10);
            if (v11 > v2) {
                v3 = v11;
            };
            v8 = v8 + 1;
        };
        v7 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v7);
        v8 = 0;
        let v12;
        let v13;
        while (v8 < v0) {
            let v14 = (*0x1::vector::borrow<u128>(arg0, v8) as u256);
            let v15 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v14, v14 + (*0x1::vector::borrow<u128>(arg4, v8) as u256));
            if (v15 <= v3) {
                v8 = v8 + 1;
                continue
            };
            v12 = 0;
            v13 = 0;
            while (v13 < v0) {
                let v16 = (*0x1::vector::borrow<u128>(arg0, v13) as u256);
                let v17 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, v16 + (*0x1::vector::borrow<u128>(arg4, v13) as u256));
                let v18 = (*0x1::vector::borrow<u64>(arg1, v13) as u256);
                let v19 = if (v17 >= v16) {
                    0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg2, v13) as u256)), v17 - v16) + v16
                } else {
                    let v20 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v16 - v17, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg3, v13) as u256)));
                    if (v16 < v20) {
                        v13 = v13 + 1;
                        continue
                    };
                    v16 - v20
                };
                v12 = v12 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v18, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v19));
                v13 = v13 + 1;
            };
            let v21 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v12);
            if (v21 >= v1) {
                if (v15 < v5) {
                    v6 = v15;
                    v7 = v21;
                };
            } else if (v15 > v3) {
                v3 = v15;
                v4 = v21;
            };
            v8 = v8 + 1;
        };
        let v22 = (v3 * v7 + (v6 - v3) * v1 - v6 * v4) / (v7 - v4);
        let v23 = v22;
        let v24 = 0x1::vector::empty<u256>();
        v13 = 0;
        while (v13 < v0) {
            let v25 = (*0x1::vector::borrow<u128>(arg0, v13) as u256);
            let v26 = if (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v22, v25 + (*0x1::vector::borrow<u128>(arg4, v13) as u256)) >= v25) {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg2, v13) as u256))
            } else {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(1000000000000000000, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg3, v13) as u256)))
            };
            0x1::vector::push_back<u256>(&mut v24, v26);
            v13 = v13 + 1;
        };
        v8 = 0;
        let v27 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        while (v8 < 255) {
            v13 = 0;
            v12 = 0;
            let v28 = 0;
            while (v13 < v0) {
                let v29 = (*0x1::vector::borrow<u128>(arg0, v13) as u256);
                let v30 = (*0x1::vector::borrow<u64>(arg1, v13) as u256);
                let v31 = *0x1::vector::borrow<u256>(&v24, v13);
                let v32 = v29 + (*0x1::vector::borrow<u128>(arg4, v13) as u256);
                let v33 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v23, v32);
                let v34 = if (v33 >= v29) {
                    0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v33 - v29, v31) + v29
                } else {
                    let v35 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v29 - v33, v31);
                    assert!(v29 >= v35, 12);
                    v29 - v35
                };
                v12 = v12 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v30, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v34));
                v28 = v28 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v30, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v31, v32)), v34);
                v13 = v13 + 1;
            };
            let v36 = v23 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v1, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v28, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v12)));
            let v37 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(1000000000000000000, v28);
            let v38 = if (v37 > v36) {
                54210108624275221
            } else {
                v36 - v37
            };
            v23 = v38;
            let v39 = if (v27 < v38) {
                v38 - v27
            } else {
                v27 - v38
            };
            if (v39 <= 1000000000) {
                break
            };
            v8 = v8 + 1;
        };
        assert!(v8 < 255, 2);
        (v23 as u64)
    }

    public fun calc_in_given_out(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) : u64 {
        let v0 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down((calc_in_given_out_direct(arg0, arg1, arg2, arg3, arg4, arg5, arg7) as u256), (arg6 as u256));
        assert!(v0 <= 18446744073709551615, 7);
        assert!(v0 >= 54210108624275221, 8);
        (v0 as u64)
    }

    public fun calc_in_given_out_direct(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) : u128 {
        assert!(arg5 != 1000000000000000000, 4);
        let v0 = (arg1 as u256);
        let v1 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up((arg6 as u256), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((arg5 as u256)));
        assert!(v1 < v0, 6);
        (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_up((arg0 as u256), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::pow_up(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up(v0, v0 - v1), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up((arg3 as u256), (arg2 as u256))) - 1000000000000000000), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((arg4 as u256))) as u128)
    }

    public fun calc_invariant(arg0: &vector<u128>, arg1: &vector<u64>) : u128 {
        let v0 = (calc_invariant_full(arg0, arg1) as u128);
        assert!(v0 >= 1, 1);
        v0
    }

    public fun calc_invariant_full(arg0: &vector<u128>, arg1: &vector<u64>) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg1)) {
            let v3 = (*0x1::vector::borrow<u64>(arg1, v2) as u256);
            assert!(v3 > 0, 11);
            v1 = v1 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v3, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln((*0x1::vector::borrow<u128>(arg0, v2) as u256)));
            v0 = v0 + v3;
            v2 = v2 + 1;
        };
        let v4 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v1);
        assert!(v0 == 1000000000000000000, 0);
        assert!(v4 >= 1000000000000000000, 1);
        v4
    }

    public fun calc_invariant_up(arg0: &vector<u128>, arg1: &vector<u64>) : u128 {
        let v0 = (calc_invariant_up_full(arg0, arg1) as u128);
        assert!(v0 >= 1, 1);
        v0
    }

    public fun calc_invariant_up_full(arg0: &vector<u128>, arg1: &vector<u64>) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg1)) {
            let v3 = (*0x1::vector::borrow<u64>(arg1, v2) as u256);
            assert!(v3 > 0, 11);
            v1 = v1 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_up(v3, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln((*0x1::vector::borrow<u128>(arg0, v2) as u256)));
            v0 = v0 + v3;
            v2 = v2 + 1;
        };
        let v4 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp_up(v1);
        assert!(v0 == 1000000000000000000, 0);
        assert!(v4 >= 1000000000000000000, 1);
        v4
    }

    public fun calc_out_given_in(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) : u64 {
        let v0 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down((calc_out_given_in_direct(arg0, arg1, arg2, arg3, arg4, arg5, arg6) as u256), (arg7 as u256));
        assert!(v0 <= 18446744073709551615, 7);
        assert!(v0 >= 54210108624275221, 8);
        (v0 as u64)
    }

    public fun calc_out_given_in_direct(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) : u128 {
        assert!(arg5 != 1000000000000000000, 4);
        let v0 = (arg0 as u256);
        (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down((arg1 as u256), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::pow_up(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up(v0, v0 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down((arg6 as u256), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((arg4 as u256)))), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down((arg2 as u256), (arg3 as u256))))), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((arg5 as u256))) as u128)
    }

    public fun calc_spot_price(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : u128 {
        (calc_spot_price_full((arg0 as u256), (arg1 as u256), (arg2 as u256), (arg3 as u256)) as u128)
    }

    public fun calc_spot_price_full(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(arg0, arg2), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(arg1, arg3))
    }

    public fun calc_spot_price_full_with_fees(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(calc_spot_price_full(arg0, arg1, arg2, arg3), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(arg4), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(arg5)))
    }

    public fun calc_spot_price_with_fees(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u128 {
        (calc_spot_price_full_with_fees((arg0 as u256), (arg1 as u256), (arg2 as u256), (arg3 as u256), (arg4 as u256), (arg5 as u256)) as u128)
    }

    public fun calc_swap_fixed_in(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: &vector<u128>) : u64 {
        let v0 = 0x1::vector::length<u128>(arg0);
        let v1 = calc_invariant_full(arg0, arg1);
        let v2 = 0x1::vector::empty<u256>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = (*0x1::vector::borrow<u128>(arg4, v3) as u256);
            let v5 = (*0x1::vector::borrow<u128>(arg5, v3) as u256);
            assert!(v4 == 0 || v5 == 0, 3);
            let v6 = if (v4 > v5) {
                (*0x1::vector::borrow<u64>(arg2, v3) as u256)
            } else if (v4 < v5) {
                (*0x1::vector::borrow<u64>(arg3, v3) as u256)
            } else {
                0
            };
            assert!(v6 != 1000000000000000000, 4);
            0x1::vector::push_back<u256>(&mut v2, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(v6));
            v3 = v3 + 1;
        };
        let v7 = 1000000000000000000;
        let v8 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v9 = 0;
        while (v9 < 255) {
            let v10 = 0;
            let v11 = 0;
            v3 = 0;
            while (v3 < v0) {
                let v12 = (*0x1::vector::borrow<u64>(arg1, v3) as u256);
                let v13 = (*0x1::vector::borrow<u128>(arg4, v3) as u256);
                let v14 = (*0x1::vector::borrow<u128>(arg5, v3) as u256);
                let v15 = *0x1::vector::borrow<u256>(&v2, v3);
                let (v16, v17) = if (v13 >= v14) {
                    let v18 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v7, v14);
                    assert!(v13 >= v18, 12);
                    let v19 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, v13 - v18) + (*0x1::vector::borrow<u128>(arg0, v3) as u256);
                    (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, v14)), v19), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v19)))
                } else {
                    let v20 = v13 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, (*0x1::vector::borrow<u128>(arg0, v3) as u256));
                    let v21 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v7, v14);
                    assert!(v20 >= v21, 12);
                    let v22 = v20 - v21;
                    (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, v14), v22), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v22, v15))))
                };
                v10 = v10 + v17;
                v11 = v11 + v16;
                v3 = v3 + 1;
            };
            let v23 = v7 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(1000000000000000000, v11);
            let v24 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v1, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v11, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v10)));
            let v25 = if (v24 > v23) {
                54210108624275221
            } else {
                v23 - v24
            };
            v7 = v25;
            let v26 = if (v8 < v25) {
                v25 - v8
            } else {
                v8 - v25
            };
            if (v26 <= 1000000000) {
                break
            };
            v9 = v9 + 1;
        };
        assert!(v9 < 255, 2);
        assert!(v7 <= 18446744073709551615, 7);
        assert!(v7 >= 54210108624275221, 8);
        let v27 = 0x1::vector::empty<u128>();
        v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<u128>(&mut v27, (((*0x1::vector::borrow<u128>(arg0, v3) as u256) + (*0x1::vector::borrow<u128>(arg4, v3) as u256) - 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v7, (*0x1::vector::borrow<u128>(arg5, v3) as u256))) as u128));
            v3 = v3 + 1;
        };
        assert!(calc_invariant_full(&v27, arg1) >= v1, 13);
        (v7 as u64)
    }

    public fun calc_swap_fixed_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: &vector<u128>) : u64 {
        let v0 = 0x1::vector::length<u128>(arg0);
        let v1 = calc_invariant_full(arg0, arg1);
        let v2 = 0x1::vector::empty<u256>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = (*0x1::vector::borrow<u128>(arg4, v3) as u256);
            let v5 = (*0x1::vector::borrow<u128>(arg5, v3) as u256);
            assert!(v4 == 0 || v5 == 0, 3);
            let v6 = if (v4 > v5) {
                (*0x1::vector::borrow<u64>(arg2, v3) as u256)
            } else if (v4 < v5) {
                (*0x1::vector::borrow<u64>(arg3, v3) as u256)
            } else {
                0
            };
            assert!(v6 != 1000000000000000000, 4);
            0x1::vector::push_back<u256>(&mut v2, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(v6));
            v3 = v3 + 1;
        };
        let v7 = 1000000000000000000;
        let v8 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v9 = 0;
        while (v9 < 255) {
            let v10 = 0;
            let v11 = 0;
            v3 = 0;
            while (v3 < v0) {
                let v12 = (*0x1::vector::borrow<u64>(arg1, v3) as u256);
                let v13 = (*0x1::vector::borrow<u128>(arg4, v3) as u256);
                let v14 = (*0x1::vector::borrow<u128>(arg5, v3) as u256);
                let v15 = *0x1::vector::borrow<u256>(&v2, v3);
                let (v16, v17) = if (v13 >= v14) {
                    let v18 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v7, v13);
                    assert!(v18 >= v14, 12);
                    let v19 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, v18 - v14) + (*0x1::vector::borrow<u128>(arg0, v3) as u256);
                    (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, v13)), v19), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v19)))
                } else {
                    let v20 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, (*0x1::vector::borrow<u128>(arg0, v3) as u256)) + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v7, v13);
                    assert!(v14 < v20, 6);
                    let v21 = v20 - v14;
                    (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, v13), v21), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v21, v15))))
                };
                v10 = v10 + v17;
                v11 = v11 + v16;
                v3 = v3 + 1;
            };
            let v22 = v7 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v1, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v11, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v10)));
            let v23 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(1000000000000000000, v11);
            let v24 = if (v23 > v22) {
                54210108624275221
            } else {
                v22 - v23
            };
            v7 = v24;
            let v25 = if (v8 < v24) {
                v24 - v8
            } else {
                v8 - v24
            };
            if (v25 <= 1000000000) {
                break
            };
            v9 = v9 + 1;
        };
        assert!(v9 < 255, 2);
        assert!(v7 <= 18446744073709551615, 7);
        assert!(v7 >= 54210108624275221, 8);
        let v26 = 0x1::vector::empty<u128>();
        v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<u128>(&mut v26, (((*0x1::vector::borrow<u128>(arg0, v3) as u256) + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v7, (*0x1::vector::borrow<u128>(arg4, v3) as u256)) - (*0x1::vector::borrow<u128>(arg5, v3) as u256)) as u128));
            v3 = v3 + 1;
        };
        assert!(calc_invariant_full(&v26, arg1) >= v1, 13);
        (v7 as u64)
    }

    public fun calc_withdraw_fixed_amounts(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128) : u64 {
        assert!(arg5 > (1000000000000000000 as u128), 5);
        let v0 = 0x1::vector::length<u128>(arg0);
        let v1 = calc_invariant_full(arg0, arg1);
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v6 = v5;
        let v7 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v8 = 0;
        let v9;
        let v10;
        while (v8 < v0) {
            let v11 = (*0x1::vector::borrow<u128>(arg0, v8) as u256);
            let v12 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v11, v11 - (*0x1::vector::borrow<u128>(arg4, v8) as u256));
            v10 = 0;
            v9 = 0;
            while (v9 < v0) {
                let v13 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
                let v14 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v12, v13 - (*0x1::vector::borrow<u128>(arg4, v9) as u256));
                let v15 = (*0x1::vector::borrow<u64>(arg1, v9) as u256);
                let v16 = (*0x1::vector::borrow<u64>(arg2, v9) as u256);
                let v17 = (*0x1::vector::borrow<u64>(arg3, v9) as u256);
                assert!(v16 != 1000000000000000000 && v17 != 1000000000000000000, 4);
                let v18 = if (v14 >= v13) {
                    0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(v16), v14 - v13) + v13
                } else {
                    let v19 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v13 - v14, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(v17));
                    if (v13 < v19) {
                        v9 = v9 + 1;
                        continue
                    };
                    v13 - v19
                };
                v10 = v10 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v15, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v18));
                v9 = v9 + 1;
            };
            let v20 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v10);
            if (v20 >= v1) {
                if (v12 < v5) {
                    v6 = v12;
                    v7 = v20;
                };
            } else if (v12 > v2) {
                v3 = v12;
                v4 = v20;
            };
            v8 = v8 + 1;
        };
        let v21 = (v3 * v7 + (v6 - v3) * v1 - v6 * v4) / (v7 - v4);
        let v22 = v21;
        let v23 = 0x1::vector::empty<u256>();
        v9 = 0;
        while (v9 < v0) {
            let v24 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
            let v25 = if (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v21, v24 - (*0x1::vector::borrow<u128>(arg4, v9) as u256)) >= v24) {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg2, v9) as u256))
            } else {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(1000000000000000000, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg3, v9) as u256)))
            };
            0x1::vector::push_back<u256>(&mut v23, v25);
            v9 = v9 + 1;
        };
        v8 = 0;
        let v26 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        while (v8 < 255) {
            v9 = 0;
            v10 = 0;
            let v27 = 0;
            while (v9 < v0) {
                let v28 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
                let v29 = (*0x1::vector::borrow<u64>(arg1, v9) as u256);
                let v30 = *0x1::vector::borrow<u256>(&v23, v9);
                let v31 = v28 - (*0x1::vector::borrow<u128>(arg4, v9) as u256);
                let v32 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v22, v31);
                let v33 = if (v32 >= v28) {
                    0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v32 - v28, v30) + v28
                } else {
                    let v34 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v28 - v32, v30);
                    assert!(v28 >= v34, 12);
                    v28 - v34
                };
                v10 = v10 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v29, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v33));
                v27 = v27 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v29, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v30, v31)), v33);
                v9 = v9 + 1;
            };
            let v35 = v22 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v1, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v27, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v10)));
            let v36 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(1000000000000000000, v27);
            let v37 = if (v36 > v35) {
                54210108624275221
            } else {
                v35 - v36
            };
            v22 = v37;
            let v38 = if (v26 < v37) {
                v37 - v26
            } else {
                v26 - v37
            };
            if (v38 <= 1000000000) {
                break
            };
            v8 = v8 + 1;
        };
        assert!(v8 < 255, 2);
        let v39 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(v22, (arg5 as u256));
        assert!(v39 <= 18446744073709551615, 9);
        assert!(v39 >= 54210108624275221, 10);
        (v39 as u64)
    }

    public fun calc_withdraw_flp_amounts_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128) : u64 {
        let v0 = (arg5 as u256);
        let v1 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(v0);
        assert!(v0 < 1000000000000000000, 5);
        let v2 = 0x1::vector::length<u128>(arg0);
        let v3 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_up(calc_invariant_full(arg0, arg1), v0);
        let v4 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v5 = v4;
        let v6 = 0;
        let v7 = v6;
        let v8 = 0;
        let v9 = 0;
        let v10 = 1000000000000000000;
        let v11 = 0;
        while (v11 < v2) {
            let v12 = (*0x1::vector::borrow<u64>(arg3, v11) as u256);
            v9 = v9 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v11) as u256), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down((*0x1::vector::borrow<u128>(arg0, v11) as u256), 1000000000000000000 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v0, v12) - v12)));
            v11 = v11 + 1;
        };
        v9 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v9);
        v11 = 0;
        while (v11 < v2) {
            let v13 = (*0x1::vector::borrow<u128>(arg0, v11) as u256);
            let v14 = (*0x1::vector::borrow<u128>(arg4, v11) as u256);
            if (v14 == 0) {
                v11 = v11 + 1;
                continue
            };
            let v15 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v13, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v0, (*0x1::vector::borrow<u64>(arg3, v11) as u256)))), v14);
            if (v15 < v4) {
                v5 = v15;
            };
            v11 = v11 + 1;
        };
        let v16 = v5;
        v11 = 0;
        let v17;
        let v18;
        let v19;
        while (v11 < v2) {
            let v20 = (*0x1::vector::borrow<u128>(arg4, v11) as u256);
            if (v20 == 0) {
                v11 = v11 + 1;
                continue
            };
            let v21 = if (*0x1::vector::borrow<u64>(arg2, v11) >= *0x1::vector::borrow<u64>(arg3, v11)) {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down((*0x1::vector::borrow<u128>(arg0, v11) as u256), v1), v20)
            } else {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_up((*0x1::vector::borrow<u128>(arg0, v11) as u256), v1), v20)
            };
            v19 = true;
            v18 = 0;
            v17 = 0;
            while (v18 < v2) {
                let v22 = (*0x1::vector::borrow<u128>(arg0, v18) as u256);
                let v23 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v22, v0);
                let v24 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_up(v21, (*0x1::vector::borrow<u128>(arg4, v18) as u256));
                if (v24 >= v22) {
                    v19 = false;
                    break
                };
                let v25 = v22 - v24;
                let v26 = (*0x1::vector::borrow<u64>(arg2, v18) as u256);
                let v27 = (*0x1::vector::borrow<u64>(arg3, v18) as u256);
                assert!(v26 != 1000000000000000000 && v27 != 1000000000000000000, 4);
                let v28 = if (v25 >= v23) {
                    0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v25 - v23, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(v26)) + v23
                } else {
                    v23 - 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up(v23 - v25, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement(v27))
                };
                v17 = v17 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v18) as u256), 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v28));
                v18 = v18 + 1;
            };
            if (v19) {
                let v29 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v17);
                if (v29 >= v3) {
                    if (v29 < v9) {
                        v8 = v21;
                        v9 = v29;
                    };
                } else if (v29 > v6) {
                    v16 = v21;
                    v7 = v29;
                };
            };
            v11 = v11 + 1;
        };
        let v30 = if (v9 > v7) {
            (v16 * v9 + v8 * v3 - v16 * v3 - v8 * v7) / (v9 - v7)
        } else {
            (v8 * v7 + v16 * v3 - v8 * v3 - v16 * v9) / (v7 - v9)
        };
        let v31 = v30;
        let v32 = 0x1::vector::empty<u256>();
        v18 = 0;
        while (v18 < v2) {
            let v33 = if ((*0x1::vector::borrow<u128>(arg0, v18) as u256) * v1 >= v30 * (*0x1::vector::borrow<u128>(arg4, v18) as u256)) {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg2, v18) as u256))
            } else {
                0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up(1000000000000000000, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::complement((*0x1::vector::borrow<u64>(arg3, v18) as u256)))
            };
            0x1::vector::push_back<u256>(&mut v32, v33);
            v18 = v18 + 1;
        };
        v11 = 0;
        while (v11 < 255) {
            v18 = 0;
            v17 = 0;
            let v34 = 0;
            v19 = true;
            while (v18 < v2) {
                let v35 = (*0x1::vector::borrow<u128>(arg0, v18) as u256);
                let v36 = (*0x1::vector::borrow<u64>(arg1, v18) as u256);
                let v37 = *0x1::vector::borrow<u256>(&v32, v18);
                let v38 = (*0x1::vector::borrow<u128>(arg4, v18) as u256);
                let v39 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v35, v0);
                if (v35 <= 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v31, v38)) {
                    v19 = false;
                    break
                };
                let v40 = v35 - 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v31, v38);
                let v41 = if (v40 >= v39) {
                    0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v40 - v39, v37) + v39
                } else {
                    let v42 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v39 - v40, v37);
                    assert!(v39 >= v42, 12);
                    v39 - v42
                };
                v17 = v17 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v36, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::ln(v41));
                v34 = v34 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v36, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v37, v38)), v41);
                v18 = v18 + 1;
            };
            if (!v19) {
                while (v10 >= v5) {
                    v10 = v10 >> 1;
                };
                let v43 = v5 - (v10 >> (v11 as u8));
                v31 = v43;
                assert!(v43 < v5, 14);
                v11 = v11 + 1;
                continue
            };
            let v44 = v31 + 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_down(1000000000000000000, v34);
            let v45 = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::div_up(v3, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_down(v34, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::exp(v17)));
            let v46 = if (v45 > v44) {
                54210108624275221
            } else {
                v44 - v45
            };
            v31 = v46;
            if (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::close_enough(v46, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 1000000000)) {
                break
            };
            v11 = v11 + 1;
        };
        assert!(v11 < 255, 2);
        assert!(v31 <= 18446744073709551615, 7);
        assert!(0x880182bc2d65686b6f144f1af676e1a0d8cdd4dbf6e76309bf24befd2e91c6a3::stable_calculations::check_valid_withdraw_flp_amounts_out(arg0, arg1, arg2, arg3, arg4, (v31 as u128), (arg5 as u128), 0), 14);
        (v31 as u64)
    }

    // decompiled from Move bytecode v6
}

