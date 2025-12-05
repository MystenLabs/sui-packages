module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils {
    struct STABLE {
        dummy_field: bool,
    }

    struct VOLATILE {
        dummy_field: bool,
    }

    fun append_two_digits(arg0: &mut 0x1::string::String, arg1: u64) {
        if (arg1 < 10) {
            0x1::string::append(arg0, 0x1::string::utf8(b"0"));
            0x1::string::append(arg0, 0x1::u64::to_string(arg1));
        } else {
            0x1::string::append(arg0, 0x1::u64::to_string(arg1));
        };
    }

    fun append_zeros(arg0: &mut 0x1::string::String, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1) {
            0x1::string::append(arg0, 0x1::string::utf8(b"0"));
            v0 = v0 + 1;
        };
    }

    fun count_trailing_zeros10(arg0: u64, arg1: u64) : u64 {
        let v0 = 0;
        loop {
            let v1 = if (v0 < arg1) {
                if (arg0 != 0) {
                    arg0 % 10 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                arg0 = arg0 / 10;
                v0 = v0 + 1;
            } else {
                break
            };
        };
        v0
    }

    public fun format_amount_1dp(arg0: u64, arg1: u8) : 0x1::string::String {
        format_amount_min_frac(arg0, arg1, 1)
    }

    public fun format_amount_min_frac(arg0: u64, arg1: u8, arg2: u8) : 0x1::string::String {
        if (arg1 == 0) {
            let v0 = 0x1::u64::to_string(arg0);
            if ((arg2 as u64) > 0) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"."));
                let v1 = &mut v0;
                append_zeros(v1, (arg2 as u64));
            };
            return v0
        };
        let v2 = 0x1::u64::pow(10, arg1);
        let v3 = arg0 % v2;
        let v4 = 0x1::u64::to_string(arg0 / v2);
        0x1::string::append(&mut v4, 0x1::string::utf8(b"."));
        if (v3 == 0) {
            let v5 = if ((arg2 as u64) == 0) {
                1
            } else {
                (arg2 as u64)
            };
            let v6 = &mut v4;
            append_zeros(v6, v5);
            return v4
        };
        let v7 = count_trailing_zeros10(v3, (arg1 as u64));
        let v8 = (arg1 as u64) - v7;
        let v9 = v3 / 0x1::u64::pow(10, (v7 as u8));
        let v10 = num_digits10(v9);
        let v11 = if (v8 > v10) {
            v8 - v10
        } else {
            0
        };
        let v12 = &mut v4;
        append_zeros(v12, v11);
        0x1::string::append(&mut v4, 0x1::u64::to_string(v9));
        v4
    }

    public fun format_dd_mm_yyyy_utc(arg0: u64) : 0x1::string::String {
        let (v0, v1, v2) = ymd_from_unix_ms(arg0);
        let v3 = 0x1::string::utf8(b"");
        let v4 = &mut v3;
        append_two_digits(v4, v2);
        0x1::string::append(&mut v3, 0x1::string::utf8(b"."));
        let v5 = &mut v3;
        append_two_digits(v5, v1);
        0x1::string::append(&mut v3, 0x1::string::utf8(b"."));
        0x1::string::append(&mut v3, 0x1::u64::to_string(v0));
        v3
    }

    public fun is_stable<T0>() : bool {
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<STABLE>()) {
            true
        } else {
            assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<VOLATILE>(), 0);
            false
        }
    }

    public fun new_pool_key<T0, T1>(arg0: bool) : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let v6 = 0;
        let v7 = false;
        while (v6 < v5) {
            let v8 = *0x1::vector::borrow<u8>(&v3, v6);
            if (!v7 && v6 < v4) {
                let v9 = *0x1::vector::borrow<u8>(&v1, v6);
                if (v9 < v8) {
                    abort 6
                };
                if (v9 > v8) {
                    v7 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v8);
            v6 = v6 + 1;
        };
        if (!v7) {
            if (v4 < v5) {
                abort 6
            };
            if (v4 == v5) {
                abort 3
            };
        };
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<bool>(&arg0));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    fun num_digits10(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 / 10;
            v0 = v0 + 1;
        };
        v0
    }

    public fun ymd_from_unix_ms(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 86400000 + 719468;
        let v1 = v0 / 146097;
        let v2 = v0 - v1 * 146097;
        let v3 = (v2 - v2 / 1460 + v2 / 36524 - v2 / 146096) / 365;
        let v4 = v2 - 365 * v3 + v3 / 4 - v3 / 100 + v3 / 400;
        let v5 = (5 * v4 + 2) / 153;
        let v6 = if (v5 < 10) {
            v5 + 3
        } else {
            v5 - 9
        };
        let v7 = if (v6 <= 2) {
            v3 + v1 * 400 + 1
        } else {
            v3 + v1 * 400
        };
        (v7, v6, v4 - (153 * v5 + 2) / 5 + 1)
    }

    // decompiled from Move bytecode v6
}

