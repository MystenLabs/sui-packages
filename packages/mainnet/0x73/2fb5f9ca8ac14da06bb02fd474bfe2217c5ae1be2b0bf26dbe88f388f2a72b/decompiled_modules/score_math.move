module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math {
    fun exp2_frac_q64(arg0: u128) : u256 {
        let v0 = vector[26087635650665564425, 21936999301089678047, 20116317054877281742, 19263451207323153962, 18850675170876015534, 18647615946650685159, 18546908069882975960, 18496758270674070881, 18471734244850835106, 18459234930309000272, 18452988445124272033, 18449865995240371898, 18448304968436414829, 18447524504564044946, 18447134285009651015, 18446939178327825412, 18446841625760745902, 18446792849670663277, 18446768461673986097, 18446756267687738522, 18446750170697637486, 18446747122203342655, 18446745597956384162, 18446744835832952145, 18446744454771247945, 18446744264240398796, 18446744168974974960, 18446744121342263227, 18446744097525907406, 18446744085617729507, 18446744079663640561, 18446744076686596088];
        let v1 = 18446744073709551616;
        let v2 = 0;
        while (v2 < 32) {
            if (arg0 >> 31 - v2 & 1 == 1) {
                let v3 = v1 * (*0x1::vector::borrow<u128>(&v0, (v2 as u64)) as u256);
                v1 = v3 / 18446744073709551616;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun expect<T0>(arg0: 0x1::option::Option<T0>) : T0 {
        assert!(0x1::option::is_some<T0>(&arg0), 0);
        0x1::option::destroy_some<T0>(arg0)
    }

    public(friend) fun exponent_q32(arg0: u64, arg1: u64) : u128 {
        let v0 = if (arg0 < 1790812800000) {
            1790812800000
        } else {
            arg0
        };
        (((v0 - 1790812800000) as u128) << 32) / (arg1 as u128)
    }

    public(friend) fun factor_tenths(arg0: u8) : u64 {
        if (arg0 >= 5) {
            10
        } else if (arg0 == 4) {
            8
        } else if (arg0 == 3) {
            5
        } else {
            0
        }
    }

    public(friend) fun origin_ms() : u64 {
        1790812800000
    }

    public(friend) fun try_exp2_q32(arg0: u128) : 0x1::option::Option<u128> {
        if (arg0 >> 32 >= 96) {
            return 0x1::option::none<u128>()
        };
        try_fit((exp2_frac_q64(arg0 & 4294967295) << ((arg0 >> 32) as u8)) / 4294967296)
    }

    public(friend) fun try_fit(arg0: u256) : 0x1::option::Option<u128> {
        if (arg0 <= 340282366920938463463374607431768211455) {
            0x1::option::some<u128>((arg0 as u128))
        } else {
            0x1::option::none<u128>()
        }
    }

    public(friend) fun try_growth_q32(arg0: u64, arg1: u64) : 0x1::option::Option<u128> {
        try_exp2_q32(exponent_q32(arg0, arg1))
    }

    public(friend) fun try_half_growth_q32(arg0: u64, arg1: u64) : 0x1::option::Option<u128> {
        try_exp2_q32(exponent_q32(arg0, arg1) / 2)
    }

    public(friend) fun unrated_tenths() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

