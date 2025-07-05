module 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::oracle_helper {
    struct Sample has copy, drop, store {
        oracle_length: u16,
        cumulative_id: u64,
        cumulative_volatility: u64,
        cumulative_bin_crossed: u64,
        sample_lifetime: u8,
        created_at: u64,
    }

    struct Oracle has store {
        samples: vector<Sample>,
        initialized: bool,
    }

    fun binary_search(arg0: &Oracle, arg1: u16, arg2: u64, arg3: u16) : (Sample, Sample) {
        let v0 = 0;
        let v1 = ((arg3 - 1) as u64);
        let v2 = Sample{
            oracle_length          : 0,
            cumulative_id          : 0,
            cumulative_volatility  : 0,
            cumulative_bin_crossed : 0,
            sample_lifetime        : 0,
            created_at             : 0,
        };
        let v3 = 0;
        if (arg3 == 1) {
            v2 = get_sample(arg0, 1);
            return (v2, v2)
        };
        while (v0 <= v1) {
            let v4 = v0 + v1 >> 1;
            v2 = get_sample(arg0, ((((arg1 as u64) + v4 - 1) % (arg3 as u64) + 1) as u16));
            let v5 = get_sample_last_update(&v2);
            v3 = v5;
            if (v5 > arg2) {
                if (v4 == 0) {
                    break
                };
                v1 = v4 - 1;
                continue
            };
            if (v5 < arg2) {
                v0 = v4 + 1;
                continue
            };
            return (v2, v2)
        };
        assert!(v0 <= (arg3 as u64) + 1, 6);
        if (arg2 < v3) {
            let v8 = if (v0 == 0) {
                0
            } else {
                v0 - 1
            };
            let v9 = ((arg1 as u64) + v8 - 1) % (arg3 as u64) + 1;
            let v10 = if (v9 == 1) {
                (arg3 as u64)
            } else {
                v9 - 1
            };
            (get_sample(arg0, (v10 as u16)), v2)
        } else {
            let v11 = if (v0 == 0) {
                0
            } else {
                v0 - 1
            };
            let v12 = ((arg1 as u64) + v11 - 1) % (arg3 as u64) + 1;
            let v13 = if (v12 == (arg3 as u64)) {
                1
            } else {
                v12 + 1
            };
            (v2, get_sample(arg0, (v13 as u16)))
        }
    }

    public fun create_sample(arg0: u16, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64) : Sample {
        Sample{
            oracle_length          : arg0,
            cumulative_id          : arg1,
            cumulative_volatility  : arg2,
            cumulative_bin_crossed : arg3,
            sample_lifetime        : arg4,
            created_at             : arg5,
        }
    }

    fun ensure_initialized(arg0: &mut Oracle, arg1: u16) {
        if (!arg0.initialized || 0x1::vector::length<Sample>(&arg0.samples) < (arg1 as u64)) {
            while (0x1::vector::length<Sample>(&arg0.samples) < (arg1 as u64)) {
                let v0 = Sample{
                    oracle_length          : 0,
                    cumulative_id          : 0,
                    cumulative_volatility  : 0,
                    cumulative_bin_crossed : 0,
                    sample_lifetime        : 0,
                    created_at             : 0,
                };
                0x1::vector::push_back<Sample>(&mut arg0.samples, v0);
            };
            arg0.initialized = true;
        };
    }

    public fun get_active_sample_and_size(arg0: &Oracle, arg1: u16) : (Sample, u16) {
        let v0 = get_sample(arg0, arg1);
        let v1 = v0.oracle_length;
        let v2 = v1;
        if (arg1 != v1 && v1 > 0) {
            let v3 = get_sample(arg0, v1);
            let v4 = v3.oracle_length;
            let v5 = if (arg1 > v4) {
                arg1
            } else {
                v4
            };
            v2 = v5;
        };
        (v0, v2)
    }

    public fun get_cumulative_bin_crossed(arg0: &Sample) : u64 {
        arg0.cumulative_bin_crossed
    }

    public fun get_cumulative_id(arg0: &Sample) : u64 {
        arg0.cumulative_id
    }

    public fun get_cumulative_volatility(arg0: &Sample) : u64 {
        arg0.cumulative_volatility
    }

    public fun get_max_sample_lifetime() : u8 {
        120
    }

    public fun get_oracle_length(arg0: &Sample) : u16 {
        arg0.oracle_length
    }

    public fun get_sample(arg0: &Oracle, arg1: u16) : Sample {
        assert!(arg1 > 0, 800);
        let v0 = ((arg1 - 1) as u64);
        if (v0 < 0x1::vector::length<Sample>(&arg0.samples)) {
            *0x1::vector::borrow<Sample>(&arg0.samples, v0)
        } else {
            Sample{oracle_length: 0, cumulative_id: 0, cumulative_volatility: 0, cumulative_bin_crossed: 0, sample_lifetime: 0, created_at: 0}
        }
    }

    public fun get_sample_at(arg0: &Oracle, arg1: u16, arg2: u64) : (u64, u64, u64, u64) {
        let (v0, v1) = get_active_sample_and_size(arg0, arg1);
        let v2 = v0;
        if (v1 == 0) {
            return (0, 0, 0, 0)
        };
        let v3 = if (arg1 <= v1) {
            1
        } else {
            (arg1 - 1) % v1 + 1
        };
        let v4 = get_sample(arg0, v3);
        if (v4.created_at == 0) {
            return (0, 0, 0, 0)
        };
        assert!(get_sample_last_update(&v4) <= arg2, 802);
        let v5 = get_sample_last_update(&v2);
        if (v5 <= arg2) {
            return (v5, v2.cumulative_id, v2.cumulative_volatility, v2.cumulative_bin_crossed)
        };
        let (v6, v7) = binary_search(arg0, arg1, arg2, v1);
        let v8 = v7;
        let v9 = v6;
        let (v10, v11, v12) = get_weighted_average(&v9, &v8, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::sub_u64(get_sample_last_update(&v8), arg2), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::sub_u64(arg2, get_sample_last_update(&v9)));
        (arg2, v10, v11, v12)
    }

    public fun get_sample_creation(arg0: &Sample) : u64 {
        arg0.created_at
    }

    public fun get_sample_last_update(arg0: &Sample) : u64 {
        0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg0.created_at, (arg0.sample_lifetime as u64))
    }

    public fun get_sample_lifetime(arg0: &Sample) : u8 {
        arg0.sample_lifetime
    }

    public fun get_weighted_average(arg0: &Sample, arg1: &Sample, arg2: u64, arg3: u64) : (u64, u64, u64) {
        assert!(arg2 > 0 || arg3 > 0, 5);
        if (arg3 == 0) {
            return (arg0.cumulative_id, arg0.cumulative_volatility, arg0.cumulative_bin_crossed)
        };
        if (arg2 == 0) {
            return (arg1.cumulative_id, arg1.cumulative_volatility, arg1.cumulative_bin_crossed)
        };
        let v0 = (arg2 as u128);
        let v1 = (arg3 as u128);
        let v2 = (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(arg2, arg3) as u128);
        (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u128_to_u64((0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg0.cumulative_id as u128), v0) + 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg1.cumulative_id as u128), v1)) / v2), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u128_to_u64((0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg0.cumulative_volatility as u128), v0) + 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg1.cumulative_volatility as u128), v1)) / v2), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u128_to_u64((0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg0.cumulative_bin_crossed as u128), v0) + 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg1.cumulative_bin_crossed as u128), v1)) / v2))
    }

    public fun increase_length(arg0: &mut Oracle, arg1: u16, arg2: u16) {
        let v0 = get_sample(arg0, arg1);
        let v1 = v0.oracle_length;
        assert!(v1 < arg2, 801);
        let v2 = if (v1 == arg1) {
            v0
        } else if (v1 == 0) {
            Sample{oracle_length: 0, cumulative_id: 0, cumulative_volatility: 0, cumulative_bin_crossed: 0, sample_lifetime: 0, created_at: 0}
        } else {
            get_sample(arg0, v1)
        };
        let v3 = v2;
        let v4 = v3.oracle_length;
        let v5 = if (arg1 > v4) {
            arg1
        } else {
            v4
        };
        ensure_initialized(arg0, arg2);
        while (v1 < arg2) {
            let v6 = Sample{
                oracle_length          : v5,
                cumulative_id          : 0,
                cumulative_volatility  : 0,
                cumulative_bin_crossed : 0,
                sample_lifetime        : 0,
                created_at             : 0,
            };
            set_sample(arg0, ((v1 + 1) as u16), v6);
            v1 = v1 + 1;
        };
        let v7 = Sample{
            oracle_length          : arg2,
            cumulative_id          : v0.cumulative_id,
            cumulative_volatility  : v0.cumulative_volatility,
            cumulative_bin_crossed : v0.cumulative_bin_crossed,
            sample_lifetime        : v0.sample_lifetime,
            created_at             : v0.created_at,
        };
        set_sample(arg0, arg1, v7);
    }

    public fun new() : Oracle {
        Oracle{
            samples     : 0x1::vector::empty<Sample>(),
            initialized : false,
        }
    }

    public fun set_sample(arg0: &mut Oracle, arg1: u16, arg2: Sample) {
        assert!(arg1 > 0, 800);
        ensure_initialized(arg0, arg1);
        *0x1::vector::borrow_mut<Sample>(&mut arg0.samples, ((arg1 - 1) as u64)) = arg2;
    }

    public fun update(arg0: &mut Oracle, arg1: &mut 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::PairParameters, arg2: u32, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_oracle_id(arg1);
        let v1 = v0;
        if (v0 == 0) {
            return false
        };
        let v2 = get_sample(arg0, v0);
        let v3 = v2.created_at;
        let v4 = v3;
        let v5 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u64(v3, (v2.sample_lifetime as u64));
        let v6 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (v6 > v5) {
            let (v7, v8, v9) = update_sample(&v2, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::sub_u64(v6, v5), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_active_id(arg1), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_volatility_accumulator(arg1), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::get_delta_id(arg1, arg2));
            let v10 = v2.oracle_length;
            let v11 = 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::sub_u64(v6, v3);
            let v12 = v11;
            if (v11 > 120) {
                let v13 = v0 % v10 + 1;
                v1 = v13;
                v12 = 0;
                v4 = v6;
                0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::pair_parameter_helper::set_oracle_id(arg1, v13);
            };
            set_sample(arg0, v1, create_sample(v10, v7, v8, v9, 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u64_to_u8(v12), v4));
            return true
        };
        false
    }

    public fun update_sample(arg0: &Sample, arg1: u64, arg2: u32, arg3: u32, arg4: u32) : (u64, u64, u64) {
        let v0 = (arg1 as u128);
        (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u128_to_u64(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u128((arg0.cumulative_id as u128), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg2 as u128), v0))), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u128_to_u64(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u128((arg0.cumulative_volatility as u128), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg3 as u128), v0))), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::u128_to_u64(0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::add_u128((arg0.cumulative_bin_crossed as u128), 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math::mul_u128((arg4 as u128), v0))))
    }

    // decompiled from Move bytecode v6
}

