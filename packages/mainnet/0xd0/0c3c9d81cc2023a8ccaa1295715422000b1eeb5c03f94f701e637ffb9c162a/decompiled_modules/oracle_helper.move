module 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::oracle_helper {
    struct Sample has copy, drop, store {
        cumulative_id: u64,
        cumulative_volatility: u64,
        cumulative_bin_crossed: u64,
        sample_lifetime: u8,
        created_at: u64,
    }

    struct Oracle has store {
        samples: vector<Sample>,
        oracle_length: u16,
        initialized: bool,
    }

    fun binary_search(arg0: &Oracle, arg1: u16, arg2: u64, arg3: u16) : (Sample, Sample) {
        let v0 = 0;
        let v1 = ((arg3 - 1) as u64);
        let v2 = Sample{
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
            let v4 = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u64(v0, v1) >> 1;
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

    fun create_sample(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u64) : Sample {
        Sample{
            cumulative_id          : arg0,
            cumulative_volatility  : arg1,
            cumulative_bin_crossed : arg2,
            sample_lifetime        : arg3,
            created_at             : arg4,
        }
    }

    fun ensure_initialized(arg0: &mut Oracle, arg1: u16) {
        if (!arg0.initialized || 0x1::vector::length<Sample>(&arg0.samples) < (arg1 as u64)) {
            while (0x1::vector::length<Sample>(&arg0.samples) < (arg1 as u64)) {
                let v0 = Sample{
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
        let v0 = arg0.oracle_length;
        let v1 = v0;
        if (arg1 != v0 && v0 > 0) {
            let v2 = arg0.oracle_length;
            let v3 = if (arg1 > v2) {
                arg1
            } else {
                v2
            };
            v1 = v3;
        };
        (get_sample(arg0, arg1), v1)
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

    public fun get_oracle_length(arg0: &Oracle) : u16 {
        arg0.oracle_length
    }

    public fun get_sample(arg0: &Oracle, arg1: u16) : Sample {
        assert!(arg1 > 0, 800);
        let v0 = ((arg1 - 1) as u64);
        if (v0 < 0x1::vector::length<Sample>(&arg0.samples)) {
            *0x1::vector::borrow<Sample>(&arg0.samples, v0)
        } else {
            Sample{cumulative_id: 0, cumulative_volatility: 0, cumulative_bin_crossed: 0, sample_lifetime: 0, created_at: 0}
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
        let (v10, v11, v12) = get_weighted_average(&v9, &v8, 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::sub_u64(get_sample_last_update(&v8), arg2), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::sub_u64(arg2, get_sample_last_update(&v9)));
        (arg2, v10, v11, v12)
    }

    public fun get_sample_creation(arg0: &Sample) : u64 {
        arg0.created_at
    }

    public fun get_sample_last_update(arg0: &Sample) : u64 {
        0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u64(arg0.created_at, (arg0.sample_lifetime as u64))
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
        let v0 = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u64(arg2, arg3);
        (0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u128_to_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u128(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg0.cumulative_id as u128), (arg2 as u128)), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg1.cumulative_id as u128), (arg3 as u128))) / (v0 as u128)), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u128_to_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u128(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg0.cumulative_volatility as u128), (arg2 as u128)), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg1.cumulative_volatility as u128), (arg3 as u128))) / (v0 as u128)), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u128_to_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u128(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg0.cumulative_bin_crossed as u128), (arg2 as u128)), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg1.cumulative_bin_crossed as u128), (arg3 as u128))) / (v0 as u128)))
    }

    public fun increase_length(arg0: &mut Oracle, arg1: u16, arg2: u16) {
        let v0 = arg0.oracle_length;
        assert!(v0 < arg2, 801);
        ensure_initialized(arg0, arg2);
        while (v0 < arg2) {
            let v1 = Sample{
                cumulative_id          : 0,
                cumulative_volatility  : 0,
                cumulative_bin_crossed : 0,
                sample_lifetime        : 0,
                created_at             : 0,
            };
            set_sample(arg0, ((v0 + 1) as u16), v1);
            v0 = v0 + 1;
        };
        arg0.oracle_length = arg2;
        if (arg1 <= arg2) {
            let v2 = get_sample(arg0, arg1);
            set_sample(arg0, arg1, v2);
        };
    }

    public fun new() : Oracle {
        Oracle{
            samples       : 0x1::vector::empty<Sample>(),
            oracle_length : 0,
            initialized   : false,
        }
    }

    public fun set_sample(arg0: &mut Oracle, arg1: u16, arg2: Sample) {
        assert!(arg1 > 0, 800);
        ensure_initialized(arg0, arg1);
        *0x1::vector::borrow_mut<Sample>(&mut arg0.samples, ((arg1 - 1) as u64)) = arg2;
    }

    public fun update(arg0: &mut Oracle, arg1: &mut 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::pair_parameter_helper::PairParameters, arg2: u32, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::pair_parameter_helper::get_oracle_id(arg1);
        let v1 = v0;
        if (v0 == 0) {
            return false
        };
        let v2 = get_sample(arg0, v0);
        let v3 = v2.created_at;
        let v4 = v3;
        let v5 = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u64(v3, (v2.sample_lifetime as u64));
        let v6 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (v6 > v5) {
            let (v7, v8, v9) = update_sample(&v2, 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::sub_u64(v6, v5), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::pair_parameter_helper::get_active_id(arg1), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::pair_parameter_helper::get_volatility_accumulator(arg1), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::pair_parameter_helper::get_delta_id(arg1, arg2));
            let v10 = 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::sub_u64(v6, v3);
            let v11 = v10;
            if (v10 > 120) {
                let v12 = v0 % arg0.oracle_length + 1;
                v1 = v12;
                v11 = 0;
                v4 = v6;
                0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::pair_parameter_helper::set_oracle_id(arg1, v12);
            };
            set_sample(arg0, v1, create_sample(v7, v8, v9, 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u64_to_u8(v11), v4));
            return true
        };
        false
    }

    public fun update_sample(arg0: &Sample, arg1: u64, arg2: u32, arg3: u32, arg4: u32) : (u64, u64, u64) {
        let v0 = if (arg1 > 300) {
            300
        } else {
            arg1
        };
        let v1 = (v0 as u128);
        (0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u128_to_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u128((arg0.cumulative_id as u128), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg2 as u128), v1))), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u128_to_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u128((arg0.cumulative_volatility as u128), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg3 as u128), v1))), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::u128_to_u64(0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::add_u128((arg0.cumulative_bin_crossed as u128), 0xd00c3c9d81cc2023a8ccaa1295715422000b1eeb5c03f94f701e637ffb9c162a::safe_math::mul_u128((arg4 as u128), v1))))
    }

    // decompiled from Move bytecode v6
}

