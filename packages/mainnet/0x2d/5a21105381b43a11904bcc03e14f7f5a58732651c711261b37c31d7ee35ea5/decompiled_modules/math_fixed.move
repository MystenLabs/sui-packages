module 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::math_fixed {
    public fun sqrt(arg0: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32) : 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32 {
        0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::create_from_raw_value((0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::math128::sqrt((0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg0) as u128) << 32) as u64))
    }

    public fun mul_div(arg0: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32, arg1: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32, arg2: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32) : 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32 {
        0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::create_from_raw_value(0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::math64::mul_div(0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg0), 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg1), 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg2)))
    }

    public fun exp(arg0: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32) : 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32 {
        0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::create_from_raw_value((exp_raw((0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg0) as u128)) as u64))
    }

    fun exp_raw(arg0: u128) : u128 {
        let v0 = arg0 / 2977044472;
        assert!(v0 <= 31, 1);
        let v1 = (v0 as u8);
        let v2 = arg0 % 2977044472;
        let v3 = 595528;
        let v4 = v2 / v3;
        let v5 = v2 % v3;
        let v6 = pow_raw(4295562865, v4);
        let v7 = v6 + (v6 * 1241009291 * v4 >> 64);
        let v8 = v7 * v5 >> 32 - v1;
        let v9 = v8 * v5 >> 32;
        (v7 << v1) + v8 + v9 / 2 + (v9 * v5 >> 32) / 6
    }

    public fun ln_plus_32ln2(arg0: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32) : 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32 {
        0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::create_from_raw_value((((0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::math128::log2((0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg0) as u128))) as u128) * 2977044472 >> 32) as u64))
    }

    public fun log2_plus_32(arg0: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32) : 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32 {
        0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::math128::log2((0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg0) as u128))
    }

    public fun pow(arg0: 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32, arg1: u64) : 0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::FixedPoint32 {
        0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::create_from_raw_value((pow_raw((0x2d5a21105381b43a11904bcc03e14f7f5a58732651c711261b37c31d7ee35ea5::fixed_point32::get_raw_value(arg0) as u128), (arg1 as u128)) as u64))
    }

    fun pow_raw(arg0: u128, arg1: u128) : u128 {
        let v0 = 18446744073709551616;
        let v1 = arg0 << 32;
        while (arg1 != 0) {
            if (arg1 & 1 != 0) {
                let v2 = v0 * (v1 as u256);
                v0 = v2 >> 64;
            };
            arg1 = arg1 >> 1;
            let v3 = (v1 as u256) * (v1 as u256) >> 64;
            v1 = (v3 as u128);
        };
        ((v0 >> 32) as u128)
    }

    // decompiled from Move bytecode v6
}

