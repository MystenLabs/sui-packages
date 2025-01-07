module 0x9c0e058e8a8f8b70efab7e9804fdd51c2762305be3cffafbb1e627a69433bbfb::stable_calculations {
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

    public fun calc_deposit_fixed_amounts(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128, arg6: u64) : u64 {
        let v0 = calc_invariant_full(arg0, arg1, arg6);
        let v1 = (arg6 as u256);
        let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v1);
        let v3 = 0x1::vector::length<u128>(arg0);
        let v4 = (arg5 as u256);
        let v5 = calc_deposit_fixed_amounts_initial_estimate(arg0, arg1, arg2, arg3, arg4, arg6);
        let v6 = 0x1::vector::empty<u256>();
        let v7 = 0;
        while (v7 < v3) {
            let v8 = (*0x1::vector::borrow<u128>(arg0, v7) as u256);
            let v9 = if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, v8 + (*0x1::vector::borrow<u128>(arg4, v7) as u256)) >= v8) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v7) as u256))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v7) as u256)))
            };
            0x1::vector::push_back<u256>(&mut v6, v9);
            v7 = v7 + 1;
        };
        let v10 = 0;
        while (v10 < 255) {
            let v11 = 0;
            let v12 = 1;
            let v13 = 0;
            let v14 = 0;
            v7 = 0;
            while (v7 < v3) {
                let v15 = (*0x1::vector::borrow<u128>(arg0, v7) as u256);
                let v16 = (*0x1::vector::borrow<u64>(arg1, v7) as u256);
                let v17 = *0x1::vector::borrow<u256>(&v6, v7);
                let v18 = v15 + (*0x1::vector::borrow<u128>(arg4, v7) as u256);
                let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v17, v5), v18) + v15 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v17, v15);
                let v20 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v16, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v17, v18));
                v11 = v11 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v16, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v19));
                v12 = v12 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v20, v19);
                v13 = v13 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v16, v19);
                v14 = v14 + v20;
                v7 = v7 + 1;
            };
            let v21 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v11);
            let v22 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, v0), v12);
            let v23 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1 << 1, v13) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2 << 1, v21)) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1 << 1, v14);
            let v24 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, v23) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, 1000000000000000000 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v0, v21)) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, v22) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1 << 1, v13) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, v21 + v0), v23 - v22);
            v5 = v24;
            if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough(v24, 0, 1000000000)) {
                let v25 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v24, v4);
                assert!(v25 <= (18446744073709551615 as u256), 1);
                assert!(v25 >= (54210108624275221 as u256), 1);
                assert!(check_valid_deposit_fixed_amounts(arg0, arg1, arg2, arg3, arg4, (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v25, v4) as u128), arg6), 7);
                return (v25 as u64)
            };
            v10 = v10 + 1;
        };
        abort 3
    }

    fun calc_deposit_fixed_amounts_initial_estimate(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u64) : u256 {
        let v0 = calc_invariant_full(arg0, arg1, arg5);
        let v1 = (arg5 as u256);
        let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v1);
        let v3 = 0x1::vector::length<u128>(arg0);
        let v4 = 0;
        let v5 = 0;
        let v6 = v5;
        let v7 = 1000000000000000000;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < v3) {
            let v11 = (*0x1::vector::borrow<u128>(arg0, v10) as u256);
            let v12 = (*0x1::vector::borrow<u128>(arg4, v10) as u256);
            let v13 = (*0x1::vector::borrow<u64>(arg1, v10) as u256);
            let v14 = v11 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v10) as u256)), v12);
            v8 = v8 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v14));
            v9 = v9 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, v14);
            let v15 = (*0x1::vector::borrow<u64>(arg3, v10) as u256) * v11 / (v11 + v12);
            if (v15 > v5) {
                v6 = v15;
            };
            v10 = v10 + 1;
        };
        let v16 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v8);
        let v17 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v16 << 1, v16 + v0)), v9) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, v16);
        let v18 = 0;
        let v19 = v18;
        while (v4 < v3) {
            let v20 = (*0x1::vector::borrow<u128>(arg0, v4) as u256);
            let v21 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v20, v20 + (*0x1::vector::borrow<u128>(arg4, v4) as u256));
            if (v21 <= v6) {
                v4 = v4 + 1;
                continue
            };
            v8 = 0;
            v9 = 0;
            v10 = 0;
            while (v10 < v3) {
                let v22 = (*0x1::vector::borrow<u128>(arg0, v10) as u256);
                let v23 = (*0x1::vector::borrow<u64>(arg1, v10) as u256);
                let v24 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v21, v22 + (*0x1::vector::borrow<u128>(arg4, v10) as u256));
                let v25 = if (v24 >= v22) {
                    v22 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v10) as u256)), v24 - v22)
                } else {
                    v22 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v22 - v24, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v10) as u256)))
                };
                v8 = v8 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v23, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v25));
                v9 = v9 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v23, v25);
                v10 = v10 + 1;
            };
            let v26 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v8);
            let v27 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v26 << 1, v26 + v0)), v9) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, v26);
            if (v27 <= v0) {
                if (v27 >= v18) {
                    v6 = v21;
                    v19 = v27;
                };
            };
            if (v27 >= v0) {
                if (v27 <= v17) {
                    v7 = v21;
                    v17 = v27;
                };
            };
            v4 = v4 + 1;
        };
        if (v19 == v17) {
            v6
        } else {
            0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v6, v17) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7 - v6, v0) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, v19), v17 - v19)
        }
    }

    public fun calc_in_given_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64) : u64 {
        assert!(arg4 != arg5, 2);
        if (arg2 >= 1000000000000000000 || arg3 >= 1000000000000000000) {
            assert!(arg7 == 0, 0);
            return 0
        };
        let v0 = (arg8 as u256);
        let v1 = (*0x1::vector::borrow<u128>(arg0, arg5) as u256);
        let v2 = (arg2 as u256);
        let v3 = (arg3 as u256);
        let v4 = (*0x1::vector::borrow<u64>(arg1, arg4) as u256);
        let v5 = (*0x1::vector::borrow<u64>(arg1, arg5) as u256);
        let (v6, _, v8, v9, v10) = calc_invariant_components(arg0, arg1, v0, arg4);
        let v11 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down((arg7 as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v3));
        let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v8, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v1 - v11, v1), v5));
        let v13 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(get_token_balance_given_invariant_and_all_other_balances(v0, v4, v10, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v6, v12), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, v4)), v12, v9 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, v11)) - (*0x1::vector::borrow<u128>(arg0, arg4) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v2));
        let v14 = (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v13, (arg6 as u256)) as u64);
        assert!(v14 >= 54210108624275221, 1);
        assert!(check_valid_1d_swap(arg0, arg1, (v2 as u64), (v3 as u64), arg4, arg5, (v13 as u128), arg7, (v0 as u64)), 6);
        v14
    }

    public fun calc_invariant(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64) : u128 {
        (calc_invariant_full(arg0, arg1, arg2) as u128)
    }

    fun calc_invariant_components(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u256, arg3: u64) : (u256, u256, u256, u256, u256) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v4 < 0x1::vector::length<u128>(arg0)) {
            let v6 = (*0x1::vector::borrow<u128>(arg0, v4) as u256);
            let v7 = (*0x1::vector::borrow<u64>(arg1, v4) as u256);
            v5 = v5 + v7;
            let v8 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v6));
            let v9 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v7, v6);
            v0 = v0 + v8;
            v1 = v1 + v9;
            if (v4 != arg3) {
                v2 = v2 + v8;
                v3 = v3 + v9;
            };
            v4 = v4 + 1;
        };
        assert!(v5 == 1000000000000000000, 5);
        let v10 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v0);
        (v10, v1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v2), v3, calc_invariant_quadratic(v10, v1, arg2))
    }

    public fun calc_invariant_full(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(arg0)) {
            let v4 = (*0x1::vector::borrow<u128>(arg0, v3) as u256);
            let v5 = (*0x1::vector::borrow<u64>(arg1, v3) as u256);
            v2 = v2 + v5;
            v0 = v0 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, v4);
            v1 = v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v4));
            v3 = v3 + 1;
        };
        assert!(v2 == 1000000000000000000, 5);
        calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v1), v0, (arg2 as u256))
    }

    fun calc_invariant_quadratic(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::sqrt(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg0, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg0, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg2, arg2) + (1000000000000000000 - arg2 << 2)) + (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg2, arg1) << 3))) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg2, arg0) >> 1
    }

    public fun calc_out_given_in(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64) : u64 {
        assert!(arg4 != arg5, 2);
        if (arg2 >= 1000000000000000000 || arg3 >= 1000000000000000000) {
            return 0
        };
        let v0 = (arg8 as u256);
        let v1 = (*0x1::vector::borrow<u128>(arg0, arg4) as u256);
        let v2 = (arg2 as u256);
        let v3 = (arg3 as u256);
        let v4 = (*0x1::vector::borrow<u64>(arg1, arg4) as u256);
        let v5 = (*0x1::vector::borrow<u64>(arg1, arg5) as u256);
        let (v6, _, v8, v9, v10) = calc_invariant_components(arg0, arg1, v0, arg5);
        let v11 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v2), (arg6 as u256));
        let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v8, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v1 + v11, v1), v4));
        let v13 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg0, arg5) as u256) - get_token_balance_given_invariant_and_all_other_balances(v0, v5, v10, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v6, v12), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, v5)), v12, v9 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v4, v11)), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v3));
        let v14 = (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v13, (arg7 as u256)) as u64);
        assert!(v14 >= 54210108624275221, 1);
        assert!(check_valid_1d_swap(arg0, arg1, (v2 as u64), (v3 as u64), arg4, arg5, arg6, (v13 as u128), (v0 as u64)), 6);
        v14
    }

    public fun calc_spot_price(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64) : u128 {
        calc_spot_price_with_fees(arg0, arg1, 0, 0, arg2, arg3, arg4)
    }

    fun calc_spot_price_body(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64) : u256 {
        let v0 = (arg2 as u256);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<u128>(arg0)) {
            let v5 = (*0x1::vector::borrow<u128>(arg0, v3) as u256);
            let v6 = (*0x1::vector::borrow<u64>(arg1, v3) as u256);
            v4 = v4 + v6;
            v1 = v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v6, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v5));
            v2 = v2 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v6, v5);
            v3 = v3 + 1;
        };
        assert!(v4 == 1000000000000000000, 5);
        let v7 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v1);
        let v8 = calc_invariant_quadratic(v7, v2, v0);
        v8 * v8 / v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v0), v7)
    }

    public fun calc_spot_price_with_fees(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u128 {
        let v0 = (arg6 as u256);
        let v1 = calc_spot_price_body(arg0, arg1, arg6);
        let v2 = (*0x1::vector::borrow<u128>(arg0, arg4) as u256);
        let v3 = (*0x1::vector::borrow<u128>(arg0, arg5) as u256);
        (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, arg5) as u256), v2), v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0 << 1, v3)), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg2 as u256)), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg3 as u256))), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, arg4) as u256), v3)), v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0 << 1, v2))) as u128)
    }

    public fun calc_swap_fixed_in(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: &vector<u128>, arg6: u64) : u64 {
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::vectors_disjoint_u128(arg4, arg5), 2);
        let v0 = calc_invariant_full(arg0, arg1, arg6);
        let v1 = (arg6 as u256);
        let v2 = 0x1::vector::length<u128>(arg0);
        let v3 = 0;
        let v4 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v5 = v4;
        let v6 = 1000000000000000000;
        while (v3 < v2) {
            let v7 = (*0x1::vector::borrow<u128>(arg5, v3) as u256);
            let v8 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v3) as u256));
            if (v7 > 0) {
                if (v8 == 0) {
                    abort 0
                };
                let v9 = ((*0x1::vector::borrow<u128>(arg0, v3) as u256) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg4, v3) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v3) as u256)))) / v7 * v8;
                if (v9 < v4) {
                    v5 = v9;
                };
            };
            v3 = v3 + 1;
        };
        if (v5 == 0) {
            abort 1
        } else {
            while (v6 >= v5) {
                v6 = v6 >> 1;
            };
            let v10 = 1000000000000000000;
            let v11 = 0;
            while (v11 < 255) {
                let v12 = 0;
                let v13 = 0;
                let v14 = 0;
                let v15 = 0;
                v3 = 0;
                let v16 = false;
                while (v3 < v2) {
                    let v17 = (*0x1::vector::borrow<u128>(arg0, v3) as u256);
                    let v18 = (*0x1::vector::borrow<u64>(arg1, v3) as u256);
                    let v19 = (*0x1::vector::borrow<u128>(arg5, v3) as u256);
                    let v20 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v3) as u256));
                    let v21 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v3) as u256)), (*0x1::vector::borrow<u128>(arg4, v3) as u256));
                    let v22 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v19), v20);
                    if (v22 >= v17 + v21 + 1000000000000000000) {
                        v16 = true;
                        break
                    };
                    let v23 = v17 + v21 - v22;
                    let v24 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18, v19), v20);
                    v12 = v12 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v23));
                    v13 = v13 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v24, v23);
                    v14 = v14 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18, v23);
                    v15 = v15 + v24;
                    v3 = v3 + 1;
                };
                if (v16) {
                    v10 = v5 - (v6 >> (v11 as u8));
                    v11 = v11 + 1;
                    continue
                };
                let v25 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v12);
                let v26 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, v14) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v1), v25);
                let v27 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, v0), v13);
                let v28 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, v14 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v15 << 1)) + v26 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13 << 1, v10), v26) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v27) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v0, v25)), (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, v26) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, v15) << 1) - v27);
                v10 = v28;
                if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough(v28, 0, 1000000000)) {
                    let v29 = (v28 as u64);
                    assert!(v29 >= 54210108624275221, 1);
                    assert!(check_valid_swap(arg0, arg1, arg2, arg3, arg4, 1000000000000000000, arg5, (v29 as u128), arg6), 6);
                    return v29
                };
                v11 = v11 + 1;
            };
            abort 3
        };
    }

    public fun calc_swap_fixed_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: &vector<u128>, arg6: u64) : u64 {
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::vectors_disjoint_u128(arg4, arg5), 2);
        let v0 = calc_invariant_full(arg0, arg1, arg6);
        let v1 = (arg6 as u256);
        let v2 = 0x1::vector::length<u128>(arg0);
        let v3 = 0;
        let v4 = 1000000000000000000;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u64>(arg3, v3) >= 1000000000000000000) {
                if (*0x1::vector::borrow<u128>(arg5, v3) > 0) {
                    abort 0
                };
            };
            v3 = v3 + 1;
        };
        let v5 = 1;
        while (v5 < 255) {
            let v6 = 0;
            let v7 = 0;
            let v8 = 0;
            let v9 = 0;
            v3 = 0;
            while (v3 < v2) {
                let v10 = (*0x1::vector::borrow<u64>(arg1, v3) as u256);
                let v11 = (*0x1::vector::borrow<u128>(arg5, v3) as u256);
                let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v3) as u256)), (*0x1::vector::borrow<u128>(arg4, v3) as u256));
                let v13 = if (v11 == 0) {
                    0
                } else {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v3) as u256)))
                };
                let v14 = (*0x1::vector::borrow<u128>(arg0, v3) as u256) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v4) - v13;
                let v15 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v12);
                v6 = v6 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v14));
                v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v15, v14);
                v8 = v8 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v14);
                v9 = v9 + v15;
                v3 = v3 + 1;
            };
            let v16 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v6);
            let v17 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v1), v16);
            let v18 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1 << 1, v8) + v17;
            let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18 + v17, v7) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1 << 1, v9) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, v0), v7);
            let v20 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v4, v19) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v0, v16)) - v18, v19);
            v4 = v20;
            if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough(v20, 0, 1000000000)) {
                let v21 = (v20 as u64);
                assert!(v21 >= 54210108624275221, 1);
                assert!(check_valid_swap(arg0, arg1, arg2, arg3, arg4, (v21 as u128), arg5, 1000000000000000000, arg6), 6);
                return v21
            };
            v5 = v5 + 1;
        };
        abort 3
    }

    public fun calc_withdraw_flp_amounts_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128, arg6: u64) : u64 {
        let v0 = (arg5 as u256);
        let v1 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v0);
        let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(calc_invariant_full(arg0, arg1, arg6), v0);
        let v3 = (arg6 as u256);
        let v4 = 0x1::vector::length<u128>(arg0);
        let v5 = 1000000000000000000;
        let (v6, v7) = calc_withdraw_flp_amounts_out_initial_estimate(arg0, arg1, arg2, arg3, arg4, (v0 as u128), arg6);
        let v8 = v6;
        while (v5 >= v7) {
            v5 = v5 >> 1;
        };
        let v9 = 0x1::vector::empty<u256>();
        let v10 = 0;
        while (v10 < v4) {
            let v11 = if ((*0x1::vector::borrow<u128>(arg0, v10) as u256) * v1 >= v6 * (*0x1::vector::borrow<u128>(arg4, v10) as u256)) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v10) as u256))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(1000000000000000000, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v10) as u256)))
            };
            0x1::vector::push_back<u256>(&mut v9, v11);
            v10 = v10 + 1;
        };
        let v12 = 0;
        while (v12 < 255) {
            let v13 = 0;
            let v14 = 0;
            let v15 = 0;
            let v16 = 0;
            v10 = 0;
            let v17 = false;
            while (v10 < v4) {
                let v18 = (*0x1::vector::borrow<u64>(arg1, v10) as u256);
                let v19 = (*0x1::vector::borrow<u128>(arg4, v10) as u256);
                let v20 = *0x1::vector::borrow<u256>(&v9, v10);
                let v21 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg0, v10) as u256), v0 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, v20));
                let v22 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v20, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v8, v19));
                if (v22 + 1000000000000000000 >= v21) {
                    v17 = true;
                    break
                };
                let v23 = v21 - v22;
                let v24 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v20, v19));
                v13 = v13 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v23));
                v14 = v14 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v24, v23);
                v15 = v15 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v18, v23);
                v16 = v16 + v24;
                v10 = v10 + 1;
            };
            if (v17) {
                v8 = v7 - (v5 >> (v12 as u8));
                v12 = v12 + 1;
                continue
            };
            let v25 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v13);
            let v26 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v25, v2);
            let v27 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v3 << 1, v15);
            let v28 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v3), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v25, v26) + (v25 << 1) + v2) + v27;
            let v29 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v28, v14) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v3 << 1, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v26 + 1000000000000000000, v16));
            let v30 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v8, v29) + v28 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v26, v27) - v25 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, (1000000000000000000 << 1) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v2, v25)), v29);
            v8 = v30;
            if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough(v30, 0, 1000000000)) {
                let v31 = (v30 as u64);
                assert!(v31 >= 54210108624275221, 1);
                assert!(check_valid_withdraw_flp_amounts_out(arg0, arg1, arg2, arg3, arg4, (v31 as u128), (v0 as u128), arg6), 8);
                return v31
            };
            v12 = v12 + 1;
        };
        abort 3
    }

    fun calc_withdraw_flp_amounts_out_initial_estimate(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128, arg6: u64) : (u256, u256) {
        let v0 = (arg5 as u256);
        let v1 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(calc_invariant_full(arg0, arg1, arg6), v0);
        let v2 = (arg6 as u256);
        let v3 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v2);
        let v4 = 0x1::vector::length<u128>(arg0);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < v4) {
            let v9 = (*0x1::vector::borrow<u64>(arg1, v8) as u256);
            let v10 = (*0x1::vector::borrow<u64>(arg2, v8) as u256);
            let v11 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg0, v8) as u256), 1000000000000000000 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, v10) - v10);
            v6 = v6 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v9, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v11));
            v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v9, v11);
            v8 = v8 + 1;
        };
        let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v6);
        let v13 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v12 << 1, v12 + v1), v7)) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v3, v12);
        let v14 = 0;
        let v15 = v14;
        let v16 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v17 = v16;
        v8 = 0;
        while (v8 < 0x1::vector::length<u128>(arg0)) {
            let v18 = (*0x1::vector::borrow<u128>(arg4, v8) as u256);
            if (v18 == 0) {
                v8 = v8 + 1;
                continue
            };
            let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg0, v8) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg3, v8) as u256), v0))), v18);
            if (v19 < v16) {
                v17 = v19;
            };
            v8 = v8 + 1;
        };
        let v20 = 0;
        while (v20 < v4) {
            let v21 = (*0x1::vector::borrow<u128>(arg4, v20) as u256);
            if (v21 == 0) {
                v20 = v20 + 1;
                continue
            };
            let v22 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg0, v20) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v0)), v21);
            v6 = 0;
            v7 = 0;
            let v23 = true;
            v8 = 0;
            while (v8 < v4) {
                let v24 = (*0x1::vector::borrow<u128>(arg0, v8) as u256);
                let v25 = (*0x1::vector::borrow<u64>(arg1, v8) as u256);
                let v26 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v22, (*0x1::vector::borrow<u128>(arg4, v8) as u256));
                if (v26 >= v24) {
                    v23 = false;
                    break
                };
                let v27 = v24 - v26;
                let v28 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, v24);
                let v29 = if (v27 >= v28) {
                    v28 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v8) as u256)), v27 - v28)
                } else {
                    v28 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v28 - v27, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v8) as u256)))
                };
                v6 = v6 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v25, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v29));
                v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v25, v29);
                v8 = v8 + 1;
            };
            if (v23) {
                let v30 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v6);
                let v31 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v30 << 1, v30 + v1), v7)) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v3, v30);
                if (v31 >= v1) {
                    if (v31 <= v13) {
                        v5 = v22;
                        v13 = v31;
                    };
                };
                if (v31 <= v1) {
                    if (v31 >= v14) {
                        v17 = v22;
                        v15 = v31;
                    };
                };
            };
            v20 = v20 + 1;
        };
        let v32 = if (v13 == v15) {
            v17
        } else {
            0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v17, v13) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, v1) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v5, v15) - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v17, v1), v13 - v15)
        };
        (v32, v17)
    }

    public fun check_valid_1d_swap(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64) : bool {
        if (arg4 == arg5) {
            return false
        };
        let v0 = (arg8 as u256);
        let v1 = 0;
        let v2 = (arg6 as u256);
        let v3 = (arg7 as u256);
        let v4 = if (v3 > 0) {
            0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v3, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg3 as u256)))
        } else {
            0
        };
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u128>(arg0)) {
            let v12 = (*0x1::vector::borrow<u128>(arg0, v11) as u256);
            let v13 = (*0x1::vector::borrow<u64>(arg1, v11) as u256);
            v1 = v1 + v13;
            let v14 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v12));
            let v15 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, v12);
            v5 = v5 + v14;
            v6 = v6 + v15;
            if (v11 == arg4) {
                let v16 = v12 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((arg2 as u256)));
                let v17 = v12 + v2;
                v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v16));
                v8 = v8 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, v16);
                v9 = v9 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v17));
                v10 = v10 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, v17);
            } else if (v11 == arg5) {
                if (v4 > v12 + 1000000000000000000 || v3 > v12 + 1000000000000000000) {
                    return false
                };
                let v18 = v12 - v4;
                let v19 = v12 - v3;
                v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v18));
                v8 = v8 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, v18);
                v9 = v9 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v19));
                v10 = v10 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v13, v19);
            } else {
                v7 = v7 + v14;
                v8 = v8 + v15;
                v9 = v9 + v14;
                v10 = v10 + v15;
            };
            v11 = v11 + 1;
        };
        if (v1 != 1000000000000000000) {
            return false
        };
        let v20 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v5), v6, v0));
        let v21 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v7), v8, v0));
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v9), v10, v0)) >= v20 && (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::very_close_int(v20, v21) || 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough_int(v20, v21, 1000000000))
    }

    public fun check_valid_deposit_fixed_amounts(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128, arg6: u64) : bool {
        let v0 = (arg5 as u256);
        if (v0 > 1000000000000000000) {
            return false
        };
        let v1 = (arg6 as u256);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u128>(arg0)) {
            let v10 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
            let v11 = (*0x1::vector::borrow<u64>(arg1, v9) as u256);
            v2 = v2 + v11;
            let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, v10 + (*0x1::vector::borrow<u128>(arg4, v9) as u256));
            let v13 = if (v12 >= v10) {
                v10 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12 - v10, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v9) as u256)))
            } else {
                let v14 = v10 - v12;
                let v15 = if (v14 > 0) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v14, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v9) as u256)))
                } else {
                    0
                };
                if (v15 >= v10 + 1000000000000000000) {
                    return false
                };
                v10 - v15
            };
            v3 = v3 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v10));
            v4 = v4 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, v10);
            v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v12));
            v8 = v8 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, v12);
            v5 = v5 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v13));
            v6 = v6 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, v13);
            v9 = v9 + 1;
        };
        if (v2 != 1000000000000000000) {
            return false
        };
        let v16 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v3), v4, v1));
        let v17 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v5), v6, v1));
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v7), v8, v1)) >= v16 && (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::very_close_int(v16, v17) || 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough_int(v16, v17, 1000000000))
    }

    public fun check_valid_swap(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128, arg6: &vector<u128>, arg7: u128, arg8: u64) : bool {
        let v0 = (arg8 as u256);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u128>(arg0)) {
            let v9 = (*0x1::vector::borrow<u128>(arg0, v8) as u256);
            let v10 = (*0x1::vector::borrow<u64>(arg1, v8) as u256);
            v1 = v1 + v10;
            let v11 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg4, v8) as u256), (arg5 as u256));
            let v12 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg6, v8) as u256), (arg7 as u256));
            if (v11 > 0 && v12 > 0) {
                abort 2
            };
            let v13 = if (v12 > 0) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v8) as u256)))
            } else {
                0
            };
            let v14 = v9 + v11;
            if (v12 > v14 + 1000000000000000000) {
                return false
            };
            let v15 = v14 - v12;
            let v16 = v9 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v8) as u256)));
            if (v13 > v16 + 1000000000000000000) {
                return false
            };
            let v17 = v16 - v13;
            v2 = v2 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v9));
            v3 = v3 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v9);
            v6 = v6 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v15));
            v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v15);
            v4 = v4 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v17));
            v5 = v5 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v10, v17);
            v8 = v8 + 1;
        };
        if (v1 != 1000000000000000000) {
            return false
        };
        let v18 = calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v2), v3, v0);
        let v19 = calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v4), v5, v0);
        calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v6), v7, v0) >= v18 && (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::very_close_int(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(v18), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(v19)) || 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough(v18, v19, 1000000000))
    }

    public fun check_valid_withdraw_flp_amounts_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128, arg6: u128, arg7: u64) : bool {
        let v0 = (arg6 as u256);
        if (v0 > 1000000000000000000) {
            return false
        };
        let v1 = (arg7 as u256);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u128>(arg0)) {
            let v10 = (*0x1::vector::borrow<u128>(arg0, v9) as u256);
            let v11 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, v10);
            let v12 = (*0x1::vector::borrow<u64>(arg1, v9) as u256);
            v2 = v2 + v12;
            let v13 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg5 as u256), (*0x1::vector::borrow<u128>(arg4, v9) as u256));
            if (v13 > v11 + 1000000000000000000) {
                return false
            };
            let v14 = v10 - v13;
            let v15 = if (v14 >= v11) {
                v11 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v14 - v11, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v9) as u256)))
            } else {
                let v16 = v11 - v14;
                let v17 = if (v16 > 0) {
                    0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v16, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v9) as u256)))
                } else {
                    0
                };
                if (v17 > v11 + 1000000000000000000) {
                    return false
                };
                v11 - v17
            };
            v3 = v3 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v11));
            v4 = v4 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v11);
            v7 = v7 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v14));
            v8 = v8 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v14);
            v5 = v5 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::ln(v15));
            v6 = v6 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v12, v15);
            v9 = v9 + 1;
        };
        if (v2 != 1000000000000000000) {
            return false
        };
        let v18 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v3), v4, v1));
        let v19 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v5), v6, v1));
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::convert_fixed_to_int(calc_invariant_quadratic(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::exp(v7), v8, v1)) >= v18 && (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::very_close_int(v18, v19) || 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough_int(v18, v19, 1000000000))
    }

    public fun get_estimate_deposit_fixed_amounts(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u64) : u128 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg0)) {
            let v3 = (*0x1::vector::borrow<u128>(arg0, v2) as u256);
            let v4 = v3 + (*0x1::vector::borrow<u128>(arg4, v2) as u256);
            let v5 = if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(calc_deposit_fixed_amounts_initial_estimate(arg0, arg1, arg2, arg3, arg4, arg5), v4) < v3) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v2) as u256), calc_spot_price_body(arg0, arg1, arg5) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg5 as u256) << 1, v3)), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v2) as u256)), v3))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v2) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v2) as u256))), calc_spot_price_body(arg0, arg1, arg5) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg5 as u256) << 1, v3)), v3)
            };
            v0 = v0 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v3, v5);
            v1 = v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v4, v5);
            v2 = v2 + 1;
        };
        (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v0, v1) as u128)
    }

    public fun get_estimate_in_given_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : u128 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down_128(arg6, calc_spot_price_with_fees(arg0, arg1, arg3, arg2, arg5, arg4, arg7))
    }

    public fun get_estimate_out_given_in(arg0: &vector<u128>, arg1: &vector<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u64) : u128 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down_128(arg6, calc_spot_price_with_fees(arg0, arg1, arg2, arg3, arg4, arg5, arg7))
    }

    public fun get_estimate_swap_fixed_in(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: &vector<u128>, arg6: u64) : u128 {
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::vectors_disjoint_u128(arg4, arg5), 2);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg0)) {
            let v3 = (*0x1::vector::borrow<u128>(arg0, v2) as u256);
            let v4 = (*0x1::vector::borrow<u128>(arg4, v2) as u256);
            let v5 = if (v4 == 0) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v2) as u256), calc_spot_price_body(arg0, arg1, arg6) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg6 as u256) << 1, v3)), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v2) as u256)), v3))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v2) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v2) as u256))), calc_spot_price_body(arg0, arg1, arg6) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg6 as u256) << 1, v3)), v3)
            };
            v0 = v0 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v4, v5);
            v1 = v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg5, v2) as u256), v5);
            v2 = v2 + 1;
        };
        (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v0, v1) as u128)
    }

    public fun get_estimate_swap_fixed_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: &vector<u128>, arg6: u64) : u128 {
        assert!(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::vector::vectors_disjoint_u128(arg4, arg5), 2);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(arg0)) {
            let v3 = (*0x1::vector::borrow<u128>(arg0, v2) as u256);
            let v4 = (*0x1::vector::borrow<u128>(arg4, v2) as u256);
            let v5 = if (v4 == 0) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v2) as u256), calc_spot_price_body(arg0, arg1, arg6) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg6 as u256) << 1, v3)), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v2) as u256)), v3))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v2) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v2) as u256))), calc_spot_price_body(arg0, arg1, arg6) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg6 as u256) << 1, v3)), v3)
            };
            v0 = v0 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v4, v5);
            v1 = v1 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u128>(arg5, v2) as u256), v5);
            v2 = v2 + 1;
        };
        (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(v1, v0) as u128)
    }

    public fun get_estimate_withdraw_flp_amounts_out(arg0: &vector<u128>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u128>, arg5: u128, arg6: u64) : u128 {
        let (v0, _) = calc_withdraw_flp_amounts_out_initial_estimate(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = (arg5 as u256);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u128>(arg0)) {
            let v6 = (*0x1::vector::borrow<u128>(arg0, v5) as u256);
            let v7 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, v6);
            let v8 = (*0x1::vector::borrow<u128>(arg4, v5) as u256);
            let v9 = if (v6 - 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, v8) < v7) {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v5) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, calc_spot_price_body(arg0, arg1, arg6)) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg6 as u256) << 1, v7)), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg3, v5) as u256)), v7))
            } else {
                0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::div_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((*0x1::vector::borrow<u64>(arg1, v5) as u256), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement((*0x1::vector::borrow<u64>(arg2, v5) as u256))), 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, calc_spot_price_body(arg0, arg1, arg6)) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down((arg6 as u256) << 1, v7)), v7)
            };
            v3 = v3 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v6, v9);
            v4 = v4 + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v8, v9);
            v5 = v5 + 1;
        };
        ((0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::complement(v2) * v3 / v4) as u128)
    }

    fun get_token_balance_given_invariant_and_all_other_balances(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        let v0 = 1000000000000000000 - arg0;
        let v1 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg0, arg1);
        let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, arg1);
        let v3 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg0, arg5);
        let v4 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg0, arg2);
        let v5 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, arg2);
        let v6 = arg3;
        let v7 = 0;
        while (v7 < 255) {
            let v8 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::pow_down(v6, arg1);
            let v9 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v8, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, arg1) << 1, v6) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, arg4) << 1, v8) + (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg1, v3) << 1) + v4) + arg2 * arg2 / arg4;
            let v10 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v8, 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v0, arg4), v8) + (v3 << 1) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(arg1, v4));
            let v11 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, arg1 + 1000000000000000000) << 1, v6) + 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v2, arg4) << 1, v8) + (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::mul_down(v1, arg5) << 1);
            if (v9 < v10 || v11 < v5) {
                v6 = 1000000000000000000 >> (v7 as u8);
                v7 = v7 + 1;
                continue
            };
            let v12 = v6 * 1000000000 / v8 * (v9 - v10) * 1000000000 / (v11 - v5);
            v6 = v12;
            if (0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed::close_enough(v12, arg3, 1000000000)) {
                return v12
            };
            v7 = v7 + 1;
        };
        abort 3
    }

    // decompiled from Move bytecode v6
}

