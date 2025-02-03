module 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::volatile_math {
    fun assert_ann_is_within_range(arg0: u256, arg1: u64) {
        assert!(arg0 >= min_a(arg1) && arg0 <= max_a(arg1), 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::invalid_amplifier());
    }

    fun assert_balance_is_within_range(arg0: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 100000000000000000000, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::unsafe_value());
    }

    fun assert_gamma_is_within_range(arg0: u256) {
        assert!(arg0 >= 10000000000 && arg0 <= 50000000000000000, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::invalid_gamma());
    }

    public fun geometric_mean(arg0: vector<u256>, arg1: bool) : u256 {
        let v0 = if (arg1) {
            0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::vectors::descending_insertion_sort(arg0)
        } else {
            arg0
        };
        let v1 = v0;
        let v2 = 0x1::vector::length<u256>(&v1);
        let v3 = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::head<u256>(v1);
        let v4 = 0;
        while (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(v4, v3) > 1 && 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(v4, v3) * 1000000000000000000 >= v3) {
            let v5 = 1000000000000000000;
            let v6 = 0;
            while (v2 > v6) {
                let v7 = v5 * *0x1::vector::borrow<u256>(&v1, v6);
                v5 = v7 / v3;
                v6 = v6 + 1;
            };
            let v8 = v3 * ((0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(v2) - 1) * 1000000000000000000 + v5);
            v3 = v8 / 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(v2) * 1000000000000000000;
        };
        v3
    }

    public fun half_pow(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 / 1000000000000000000;
        if (v0 > 59) {
            return 0
        };
        let v1 = arg0 - v0 * 1000000000000000000;
        if (v1 == 0) {
            return 1000000000000000000 / 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(0x2::math::pow(2, (v0 as u8)))
        } else {
            let v2 = 1000000000000000000;
            let v3 = 1000000000000000000;
            let v4 = false;
            let v5 = 1;
            while (v5 < 256) {
                let v6 = v5 * 1000000000000000000;
                let v7 = v6 - 1000000000000000000;
                let v8 = if (v1 > v7) {
                    v4 = !v4;
                    v1 - v7
                } else {
                    v7 - v1
                };
                v2 = v2 * v8 * 500000000000000000 / 1000000000000000000 / v6;
                let v9 = if (v4) {
                    v3 - v2
                } else {
                    v3 + v2
                };
                v3 = v9;
                if (v2 < arg1) {
                    return 1000000000000000000 / 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(0x2::math::pow(2, (v0 as u8))) * v9 / 1000000000000000000
                };
                v5 = v5 + 1;
            };
            abort 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::failed_to_converge()
        };
    }

    public fun invariant_(arg0: u256, arg1: u256, arg2: vector<u256>) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg2);
        assert_ann_is_within_range(arg0, v0);
        assert_gamma_is_within_range(arg1);
        let v1 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::vectors::descending_insertion_sort(arg2);
        let v2 = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::head<u256>(v1);
        assert!(v2 >= 1000000000 && v2 <= 1000000000000000 * 1000000000000000000, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::unsafe_value());
        let v3 = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(v0);
        let v4 = 1;
        while (v0 > v4) {
            assert!(*0x1::vector::borrow<u256>(&v1, v4) * 1000000000000000000 / v2 >= 100000000000, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::unsafe_value());
            v4 = v4 + 1;
        };
        let v5 = v3 * geometric_mean(v1, false);
        let v6 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sum(v1);
        while (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(v5, 0) * 100000000000000 >= 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::max(10000000000000000, v5)) {
            let v7 = 1000000000000000000;
            let v8 = 0;
            while (v8 < v0) {
                let v9 = v7 * *0x1::vector::borrow<u256>(&v1, v8) * v3;
                v7 = v9 / v5;
                v8 = v8 + 1;
            };
            let v10 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(arg1 + 1000000000000000000, v7) + 1;
            let v11 = 1000000000000000000 * v5 / arg1 * v10 / arg1 * v10 * 10000 / arg0;
            let v12 = 2 * 1000000000000000000 * v3 * v7 / v10;
            let v13 = v6 + v6 * v12 / 1000000000000000000 + v11 * v3 / v7 - v12 * v5 / 1000000000000000000;
            let v14 = v5 * (v13 + v6) / v13;
            let v15 = if (1000000000000000000 > v7) {
                v5 * v5 / v13 + v5 * v11 / v13 / 1000000000000000000 * (1000000000000000000 - v7) / v7
            } else {
                v5 * v5 / v13 - v5 * v11 / v13 / 1000000000000000000 * (v7 - 1000000000000000000) / v7
            };
            let v16 = if (v14 > v15) {
                v14 - v15
            } else {
                (v15 - v14) / 2
            };
            v5 = v16;
        };
        let v17 = 0;
        while (v0 > v17) {
            assert_balance_is_within_range(*0x1::vector::borrow<u256>(&v1, v17) * 1000000000000000000 / v5);
            v17 = v17 + 1;
        };
        v5
    }

    public fun max_a(arg0: u64) : u256 {
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(0x2::math::pow(arg0, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u8(arg0))) * 10000 * 1000
    }

    public fun min_a(arg0: u64) : u256 {
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(0x2::math::pow(arg0, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u8(arg0))) * 10000 / 100
    }

    public fun reduction_coefficient(arg0: vector<u256>, arg1: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 0;
        let v2 = 1000000000000000000;
        while (v1 < v0) {
            let v3 = v2 * 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(v0) * *0x1::vector::borrow<u256>(&arg0, v1);
            v2 = v3 / 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sum(arg0);
            v1 = v1 + 1;
        };
        if (arg1 != 0) {
            arg1 * 1000000000000000000 / (arg1 + 1000000000000000000 - v2)
        } else {
            v2
        }
    }

    public fun sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1000000000000000000) / 2;
        while (v0 != arg0) {
            let v1 = arg0 * 1000000000000000000 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun y(arg0: u256, arg1: u256, arg2: &vector<u256>, arg3: u256, arg4: u64) : u256 {
        let v0 = 0x1::vector::length<u256>(arg2);
        assert_ann_is_within_range(arg0, v0);
        assert_gamma_is_within_range(arg1);
        assert!(arg3 >= 100000000000000000 && arg3 <= 1000000000000000 * 1000000000000000000, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::invalid_invariant());
        let v1 = 0;
        while (v0 > v1) {
            if (v1 != arg4) {
                assert_balance_is_within_range(*0x1::vector::borrow<u256>(arg2, v1) * 1000000000000000000 / arg3);
            };
            v1 = v1 + 1;
        };
        let v2 = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::to_u256(v0);
        let v3 = arg3 / v2;
        let v4 = 1000000000000000000;
        let v5 = 0;
        let v6 = *arg2;
        *0x1::vector::borrow_mut<u256>(&mut v6, arg4) = 0;
        let v7 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::vectors::descending_insertion_sort(v6);
        let v8 = 2;
        while (v8 < v0 + 1) {
            let v9 = *0x1::vector::borrow<u256>(&v7, v0 - v8);
            let v10 = v3 * arg3;
            v3 = v10 / v9 * v2;
            v5 = v5 + v9;
            v8 = v8 + 1;
        };
        let v11 = 0;
        while (v11 < v0 - 1) {
            let v12 = v4 * *0x1::vector::borrow<u256>(&v7, v11) * v2;
            v4 = v12 / arg3;
            v11 = v11 + 1;
        };
        while (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(v3, 0) >= 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::max(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::max(0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::max(0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::utils::head<u256>(v7) / 100000000000000, arg3 / 100000000000000), 100), v3 / 100000000000000)) {
            let v13 = v4 * v3 * v2 / arg3;
            let v14 = v5 + v3;
            let v15 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::diff(arg1 + 1000000000000000000, v13) + 1;
            let v16 = 1000000000000000000 * arg3 / arg1 * v15 / arg1 * v15 * 10000 / arg0;
            let v17 = 1000000000000000000 + 2 * 1000000000000000000 * v13 / v15;
            let v18 = 1000000000000000000 * v3 + v14 * v17 + v16;
            let v19 = arg3 * v17;
            if (v18 < v19) {
                v3 = v3 / 2;
                continue
            };
            let v20 = v18 - v19;
            let v21 = v20 / v3;
            let v22 = v16 / v21;
            let v23 = (v20 + 1000000000000000000 * arg3) / v21 + v22 * 1000000000000000000 / v13;
            let v24 = v22 + 1000000000000000000 * v14 / v21;
            let v25 = if (v23 < v24) {
                v3 / 2
            } else {
                v23 - v24
            };
            v3 = v25;
        };
        assert_balance_is_within_range(v3 * 1000000000000000000 / arg3);
        v3
    }

    // decompiled from Move bytecode v6
}

