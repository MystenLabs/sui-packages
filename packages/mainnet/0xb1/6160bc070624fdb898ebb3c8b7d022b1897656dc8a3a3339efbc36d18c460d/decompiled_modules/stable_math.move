module 0xb16160bc070624fdb898ebb3c8b7d022b1897656dc8a3a3339efbc36d18c460d::stable_math {
    struct StablePoolConfig has drop, store {
        init_amp_time: u64,
        init_amp: u64,
        next_amp_time: u64,
        next_amp: u64,
        scaling_factor: vector<u256>,
    }

    public fun add_liquidity_computation(arg0: u64, arg1: vector<u256>, arg2: vector<u256>, arg3: u64, arg4: u256) : (u256, vector<u256>) {
        let v0 = 0x1::vector::length<u256>(&arg1);
        let v1 = 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::create_zero_vector_u256(v0);
        let v2 = compute_d(arg0, arg1);
        let v3 = 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::add_vectors_u256(arg1, arg2);
        let v4 = compute_d(arg0, v3);
        assert!(v4 > v2, 5000);
        let v5 = if (arg4 == 0) {
            0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div_u256(v4, (1000000 as u256), (1000000000000000000 as u256))
        } else {
            let v6 = 0;
            while (v6 < v0) {
                *0x1::vector::borrow_mut<u256>(&mut v1, v6) = calculate_fee_charged(*0x1::vector::borrow<u256>(&arg1, v6), *0x1::vector::borrow<u256>(&v3, v6), v2, v4, arg3 * v0 / 4 * (v0 - 1));
                v6 = v6 + 1;
            };
            0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div_u256(arg4, compute_d(arg0, 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::subtract_vectors_u256(v3, v1)) - v2, v2)
        };
        (v5, v1)
    }

    fun calc_y(arg0: u64, arg1: u64, arg2: u256, arg3: vector<u256>, arg4: u64) : u256 {
        assert!(arg0 != arg1, 5100);
        let v0 = 0x1::vector::length<u256>(&arg3);
        let v1 = (compute_d(arg4, arg3) as u256);
        let v2 = v1;
        let v3 = 0;
        let v4 = arg4 * v0;
        let v5 = 0;
        while (v5 < v0) {
            v5 = v5 + 1;
            let v6 = if (arg0 == v5 - 1) {
                arg2
            } else if (arg1 != v5 - 1) {
                *0x1::vector::borrow<u256>(&arg3, v5 - 1)
            } else {
                continue
            };
            let v7 = v2 * v1;
            v2 = v7 / v6 * (v0 as u256);
            v3 = v3 + v6;
        };
        let v8 = v1;
        let v9 = 0;
        while (v9 < 256) {
            let v10 = v8;
            let v11 = (v8 * v8 + v2 * v1 / (0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_to_u128(v4, v0) as u256)) / (v8 + v8 + v3 + v1 / (v4 as u256) - v1);
            v8 = v11;
            if (v11 >= v10 && v11 - v10 <= 1) {
                return v11
            };
            if (v10 >= v11 && v10 - v11 <= 1) {
                return v11
            };
            v9 = v9 + 1;
        };
        v8
    }

    public fun calculate_fee_charged(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u64) : u256 {
        0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div_u256(0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::subtract_mod_u256(arg1, 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div_u256(arg3, arg0, arg2)), (arg4 as u256), (10000 as u256))
    }

    public fun compute_ask_amount(arg0: u64, arg1: u64, arg2: u256, arg3: u64, arg4: vector<u256>) : u256 {
        *0x1::vector::borrow<u256>(&arg4, arg3) - calc_y(arg1, arg3, *0x1::vector::borrow<u256>(&arg4, arg1) + arg2, arg4, arg0) - 1
    }

    public fun compute_current_amp(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 > arg2 && v0 < arg4) {
            let v2 = if (arg3 > arg1) {
                arg3 - arg1
            } else {
                arg1 - arg3
            };
            if (arg3 > arg1) {
                arg1 + 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div(v2, v0 - arg2, arg4 - arg2)
            } else {
                arg1 - 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div(v2, v0 - arg2, arg4 - arg2)
            }
        } else {
            arg3
        }
    }

    public fun compute_d(arg0: u64, arg1: vector<u256>) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg1);
        let v1 = 0;
        if (0x1::vector::contains<u256>(&arg1, &v1)) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v2 = v2 + *0x1::vector::borrow<u256>(&arg1, v3);
            v3 = v3 + 1;
        };
        let v4 = (v2 as u256);
        let v5 = (arg0 as u256) * (v0 as u256);
        let v6 = 0;
        while (v6 < 256) {
            let v7 = v4;
            v3 = 0;
            while (v3 < v0) {
                v7 = 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div_u256(v7, v4, *0x1::vector::borrow<u256>(&arg1, v3) * (v0 as u256));
                v3 = v3 + 1;
            };
            let v8 = v4;
            let v9 = (v5 * v2 + v7 * (v0 as u256)) * v4 / ((v5 - 1) * v4 + ((v0 as u256) + 1) * v7);
            v4 = v9;
            if (v9 >= v8 && v9 - v8 <= 1) {
                return v9
            };
            if (v8 >= v9 && v8 - v9 <= 1) {
                return v9
            };
            v6 = v6 + 1;
        };
        v4
    }

    public fun compute_offer_amount(arg0: u64, arg1: u256, arg2: u64, arg3: u64, arg4: vector<u256>, arg5: u64) : (u256, u256) {
        let v0 = 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div_u256(arg1, (10000 as u256), ((10000 - arg5) as u256));
        (calc_y(arg2, arg3, *0x1::vector::borrow<u256>(&arg4, arg2) - v0, arg4, arg0) - *0x1::vector::borrow<u256>(&arg4, arg3), v0 - arg1)
    }

    public fun get_cur_A_and_scaling_factors(arg0: &0x2::clock::Clock, arg1: &StablePoolConfig) : (u64, vector<u256>) {
        (compute_current_amp(arg0, arg1.init_amp, arg1.init_amp_time, arg1.next_amp, arg1.next_amp_time), arg1.scaling_factor)
    }

    public fun get_stable_config_params(arg0: &StablePoolConfig) : (u64, u64, u64, u64, vector<u256>) {
        (arg0.init_amp_time, arg0.init_amp, arg0.next_amp_time, arg0.next_amp, arg0.scaling_factor)
    }

    public fun imbalanced_liquidity_withdraw(arg0: u64, arg1: vector<u256>, arg2: u256, arg3: vector<u256>, arg4: u64) : (u256, vector<u256>) {
        let v0 = 0x1::vector::length<u256>(&arg1);
        let v1 = 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::create_zero_vector_u256(v0);
        let v2 = compute_d(arg0, arg1);
        let v3 = 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::subtract_vectors_u256(arg1, arg3);
        let v4 = 0;
        while (v4 < v0) {
            *0x1::vector::borrow_mut<u256>(&mut v1, v4) = calculate_fee_charged(*0x1::vector::borrow<u256>(&arg1, v4), *0x1::vector::borrow<u256>(&v3, v4), v2, compute_d(arg0, v3), arg4 * v0 / 4 * (v0 - 1));
            v4 = v4 + 1;
        };
        (0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::mul_div_u256(arg2, v2 - compute_d(arg0, 0x74e3caefef28c2c9c72773dd0f44a17049c5765ef68f1133b19bfcfba643da3e::math::subtract_vectors_u256(v3, v1)), v2), v1)
    }

    public fun initialize_stable_config(arg0: &0x2::clock::Clock, arg1: vector<u64>, arg2: vector<u256>, arg3: &mut 0x2::tx_context::TxContext) : StablePoolConfig {
        assert!(0x1::vector::length<u64>(&arg1) == 1, 5101);
        let v0 = *0x1::vector::borrow<u64>(&arg1, 0);
        assert!(100 < v0 && v0 < 1000000, 5102);
        StablePoolConfig{
            init_amp_time  : 0x2::clock::timestamp_ms(arg0),
            init_amp       : v0,
            next_amp_time  : 0x2::clock::timestamp_ms(arg0),
            next_amp       : v0,
            scaling_factor : arg2,
        }
    }

    public fun update_stable_config(arg0: &mut StablePoolConfig, arg1: u64, arg2: u64, arg3: u64) {
        assert!(100 < arg2 && arg2 < 1000000, 5102);
        assert!(arg2 >= arg0.init_amp && arg2 <= arg0.init_amp * 10 || arg2 < arg0.init_amp && arg2 * 10 >= arg0.init_amp, 5104);
        assert!(arg3 > arg1 && arg3 - arg1 > 86400000, 5103);
        arg0.init_amp_time = arg1;
        arg0.next_amp = arg2;
        arg0.next_amp_time = arg3;
    }

    // decompiled from Move bytecode v6
}

