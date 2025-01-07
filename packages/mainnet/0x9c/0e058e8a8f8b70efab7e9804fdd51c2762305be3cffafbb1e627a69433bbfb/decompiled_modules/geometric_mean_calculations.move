module 0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::geometric_mean_calculations {
    public fun calc_all_coin_deposit(arg0: &vector<u128>, arg1: &vector<u128>) : u64 {
        let v0 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg0)) {
            let v3 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down((*0x1::vector::borrow<u128>(arg1, v2) as u256), (*0x1::vector::borrow<u128>(arg0, v2) as u256));
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
            let v3 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down((*0x1::vector::borrow<u128>(arg1, v2) as u256), (*0x1::vector::borrow<u128>(arg0, v2) as u256));
            if (v3 > v0) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        (v1 as u64)
    }

    public fun calc_deposit_fixed_amounts(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128) : u64 {
        assert!(arg5 < (1000000000000000000 as u128), 5);
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
            let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v11, v11 + (*0x1::vector::borrow<u128>(arg4, v8) as u256));
            v10 = 0;
            v9 = 0;
            while (v9 < v0) {
                let v13 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
                let v14 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v13 + (*0x1::vector::borrow<u128>(arg4, v9) as u256));
                let v15 = (*0x1::vector::borrow<u64>(arg1, v9) as u256);
                let v16 = (*0x1::vector::borrow<u64>(arg2, v9) as u256);
                let v17 = (*0x1::vector::borrow<u64>(arg3, v9) as u256);
                assert!(v16 != 1000000000000000000 && v17 != 1000000000000000000, 4);
                let v18 = if (v14 >= v13) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v16), v14 - v13) + v13
                } else {
                    let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v13 - v14, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v17));
                    if (v13 < v19) {
                        v9 = v9 + 1;
                        continue
                    };
                    v13 - v19
                };
                v10 = v10 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v18));
                v9 = v9 + 1;
            };
            let v20 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v10);
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
            let v25 = if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v21, v24 + (*0x1::vector::borrow<u128>(arg4, v9) as u256)) >= v24) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v9) as u256))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v9) as u256)))
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
                let v31 = v28 + (*0x1::vector::borrow<u128>(arg4, v9) as u256);
                let v32 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v22, v31);
                let v33 = if (v32 >= v28) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v32 - v28, v30) + v28
                } else {
                    let v34 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v28 - v32, v30);
                    assert!(v28 >= v34, 12);
                    v28 - v34
                };
                v10 = v10 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v29, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v33));
                v27 = v27 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v29, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v30, v31)), v33);
                v9 = v9 + 1;
            };
            let v35 = v22 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v27, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v10)));
            let v36 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, v27);
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
        let v39 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v22, (arg5 as u256));
        assert!(v39 <= 18446744073709551615, 9);
        assert!(v39 >= 54210108624275221, 10);
        (v39 as u64)
    }

    public fun calc_in_given_out(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) : u64 {
        assert!(arg5 != 1000000000000000000, 4);
        let v0 = (arg1 as u256);
        let v1 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_up((arg7 as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg5 as u256)));
        assert!(v1 < v0, 6);
        let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_up(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_up((arg0 as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_up(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_up(v0, v0 - v1), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_up((arg3 as u256), (arg2 as u256))) - 1000000000000000000), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg4 as u256))), (arg6 as u256));
        assert!(v2 <= 18446744073709551615, 7);
        assert!(v2 >= 54210108624275221, 8);
        (v2 as u64)
    }

    public fun calc_invariant(arg0: &vector<u128>, arg1: &vector<u64>) : u128 {
        let v0 = (calc_invariant_full(arg0, arg1) as u128);
        assert!(v0 >= 1, 1);
        v0
    }

    public fun calc_invariant_full(arg0: &vector<u128>, arg1: &vector<u64>) : u256 {
        let v0 = 0;
        let v1 = 1000000000000000000;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg1)) {
            let v3 = (*0x1::vector::borrow<u64>(arg1, v2) as u256);
            assert!(v3 > 0, 11);
            v1 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_down((*0x1::vector::borrow<u128>(arg0, v2) as u256), v3));
            v0 = v0 + v3;
            v2 = v2 + 1;
        };
        assert!(v0 == 1000000000000000000, 0);
        assert!(v1 >= 1000000000000000000, 1);
        v1
    }

    public fun calc_out_given_in(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) : u64 {
        assert!(arg5 != 1000000000000000000, 4);
        let v0 = (arg0 as u256);
        let v1 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg1 as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_up(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_up(v0, v0 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg6 as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg4 as u256)))), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down((arg2 as u256), (arg3 as u256))))), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg5 as u256))), (arg7 as u256));
        assert!(v1 <= 18446744073709551615, 7);
        assert!(v1 >= 54210108624275221, 8);
        (v1 as u64)
    }

    public fun calc_spot_price(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : u128 {
        (calc_spot_price_full((arg0 as u256), (arg1 as u256), (arg2 as u256), (arg3 as u256)) as u128)
    }

    public fun calc_spot_price_full(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(arg0, arg2), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(arg1, arg3))
    }

    public fun calc_spot_price_full_with_fees(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(calc_spot_price_full(arg0, arg1, arg2, arg3), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(arg4), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(arg5)))
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
            0x1::vector::push_back<u256>(&mut v2, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v6));
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
                    let v18 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, v14);
                    assert!(v13 >= v18, 12);
                    let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, v13 - v18) + (*0x1::vector::borrow<u128>(arg0, v3) as u256);
                    (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, v14)), v19), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v19)))
                } else {
                    let v20 = v13 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, (*0x1::vector::borrow<u128>(arg0, v3) as u256));
                    let v21 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, v14);
                    assert!(v20 >= v21, 12);
                    let v22 = v20 - v21;
                    (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v14), v22), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v22, v15))))
                };
                v10 = v10 + v17;
                v11 = v11 + v16;
                v3 = v3 + 1;
            };
            let v23 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, v11);
            let v24 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v10)));
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
            0x1::vector::push_back<u128>(&mut v27, (((*0x1::vector::borrow<u128>(arg0, v3) as u256) + (*0x1::vector::borrow<u128>(arg4, v3) as u256) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, (*0x1::vector::borrow<u128>(arg5, v3) as u256))) as u128));
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
            0x1::vector::push_back<u256>(&mut v2, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v6));
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
                    let v18 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, v13);
                    assert!(v18 >= v14, 12);
                    let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, v18 - v14) + (*0x1::vector::borrow<u128>(arg0, v3) as u256);
                    (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, v13)), v19), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v19)))
                } else {
                    let v20 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, (*0x1::vector::borrow<u128>(arg0, v3) as u256)) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, v13);
                    assert!(v14 < v20, 6);
                    let v21 = v20 - v14;
                    (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v13), v21), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v21, v15))))
                };
                v10 = v10 + v17;
                v11 = v11 + v16;
                v3 = v3 + 1;
            };
            let v22 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v10)));
            let v23 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, v11);
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
            0x1::vector::push_back<u128>(&mut v26, (((*0x1::vector::borrow<u128>(arg0, v3) as u256) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, (*0x1::vector::borrow<u128>(arg4, v3) as u256)) - (*0x1::vector::borrow<u128>(arg5, v3) as u256)) as u128));
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
            let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v11, v11 - (*0x1::vector::borrow<u128>(arg4, v8) as u256));
            v10 = 0;
            v9 = 0;
            while (v9 < v0) {
                let v13 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
                let v14 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v13 - (*0x1::vector::borrow<u128>(arg4, v9) as u256));
                let v15 = (*0x1::vector::borrow<u64>(arg1, v9) as u256);
                let v16 = (*0x1::vector::borrow<u64>(arg2, v9) as u256);
                let v17 = (*0x1::vector::borrow<u64>(arg3, v9) as u256);
                assert!(v16 != 1000000000000000000 && v17 != 1000000000000000000, 4);
                let v18 = if (v14 >= v13) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v16), v14 - v13) + v13
                } else {
                    let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v13 - v14, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v17));
                    if (v13 < v19) {
                        v9 = v9 + 1;
                        continue
                    };
                    v13 - v19
                };
                v10 = v10 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v18));
                v9 = v9 + 1;
            };
            let v20 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v10);
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
            let v25 = if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v21, v24 - (*0x1::vector::borrow<u128>(arg4, v9) as u256)) >= v24) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v9) as u256))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v9) as u256)))
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
                let v32 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v22, v31);
                let v33 = if (v32 >= v28) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v32 - v28, v30) + v28
                } else {
                    let v34 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v28 - v32, v30);
                    assert!(v28 >= v34, 12);
                    v28 - v34
                };
                v10 = v10 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v29, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v33));
                v27 = v27 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v29, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v30, v31)), v33);
                v9 = v9 + 1;
            };
            let v35 = v22 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v27, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v10)));
            let v36 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, v27);
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
        let v39 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v22, (arg5 as u256));
        assert!(v39 <= 18446744073709551615, 9);
        assert!(v39 >= 54210108624275221, 10);
        (v39 as u64)
    }

    public fun calc_withdraw_flp_amounts_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128) : u64 {
        let v0 = (arg5 as u256);
        assert!(v0 < 1000000000000000000, 5);
        let v1 = 0x1::vector::length<u128>(arg0);
        let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(calc_invariant_full(arg0, arg1), v0);
        let v3 = 0;
        let v4 = 0;
        let v5 = v4;
        let v6 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v7 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v8 = v7;
        let v9 = 0;
        let v10;
        let v11;
        while (v9 < v1) {
            let v12 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
            let v13 = (*0x1::vector::borrow<u128>(arg4, v9) as u256);
            let v14 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v0);
            let v15 = if (v14 >= v12 || v13 == 0) {
                0
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v12 - v14, v13)
            };
            v10 = 0;
            v11 = 0;
            while (v10 < v1) {
                let v16 = (*0x1::vector::borrow<u128>(arg0, v10) as u256);
                let v17 = (*0x1::vector::borrow<u64>(arg1, v10) as u256);
                let v18 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v16, v0);
                let v19 = v16 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v15, (*0x1::vector::borrow<u128>(arg4, v10) as u256));
                let v20 = (*0x1::vector::borrow<u64>(arg2, v10) as u256);
                let v21 = (*0x1::vector::borrow<u64>(arg3, v10) as u256);
                assert!(v20 != 1000000000000000000 && v21 != 1000000000000000000, 4);
                let v22 = if (v19 >= v18) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v19 - v18, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v20)) + v18
                } else {
                    let v23 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18 - v19, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v21)));
                    if (v18 < v23) {
                        v10 = v10 + 1;
                        continue
                    };
                    v18 - v23
                };
                v11 = v11 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v17, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v22));
                v10 = v10 + 1;
            };
            let v24 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v11);
            if (v24 >= v2) {
                if (v24 < v7) {
                    v6 = v15;
                    v8 = v24;
                };
            } else if (v24 > v4) {
                v3 = v15;
                v5 = v24;
            };
            v9 = v9 + 1;
        };
        let v25 = if (v8 > v5) {
            (v3 * v8 + v6 * v2 - v3 * v2 - v6 * v5) / (v8 - v5)
        } else {
            (v6 * v5 + v3 * v2 - v6 * v2 - v3 * v8) / (v5 - v8)
        };
        let v26 = v25;
        let v27 = 0x1::vector::empty<u256>();
        v10 = 0;
        while (v10 < v1) {
            let v28 = (*0x1::vector::borrow<u128>(arg0, v10) as u256);
            let v29 = if (v28 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v25, (*0x1::vector::borrow<u128>(arg4, v10) as u256)) >= 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v28, v0)) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v10) as u256))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v10) as u256)))
            };
            0x1::vector::push_back<u256>(&mut v27, v29);
            v10 = v10 + 1;
        };
        v9 = 0;
        let v30 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        while (v9 < 255) {
            v10 = 0;
            v11 = 0;
            let v31 = 0;
            while (v10 < v1) {
                let v32 = (*0x1::vector::borrow<u128>(arg0, v10) as u256);
                let v33 = (*0x1::vector::borrow<u64>(arg1, v10) as u256);
                let v34 = *0x1::vector::borrow<u256>(&v27, v10);
                let v35 = (*0x1::vector::borrow<u128>(arg4, v10) as u256);
                let v36 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v32, v0);
                let v37 = v32 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v26, v35);
                let v38 = if (v37 >= v36) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v37 - v36, v34) + v36
                } else {
                    let v39 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v36 - v37, v34);
                    assert!(v36 >= v39, 12);
                    v36 - v39
                };
                v11 = v11 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v33, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v38));
                v31 = v31 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v33, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v34, v35)), v38);
                v10 = v10 + 1;
            };
            let v40 = v26 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, v31);
            let v41 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v2, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v31, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v11)));
            let v42 = if (v41 > v40) {
                54210108624275221
            } else {
                v40 - v41
            };
            v26 = v42;
            let v43 = if (v30 < v42) {
                v42 - v30
            } else {
                v30 - v42
            };
            if (v43 <= 1000000000) {
                break
            };
            v9 = v9 + 1;
        };
        assert!(v9 < 255, 2);
        assert!(v26 <= 18446744073709551615, 7);
        assert!(v26 >= 54210108624275221, 8);
        (v26 as u64)
    }

    // decompiled from Move bytecode v6
}

