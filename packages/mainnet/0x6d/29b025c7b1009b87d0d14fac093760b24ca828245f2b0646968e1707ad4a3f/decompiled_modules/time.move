module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time {
    fun add_span(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (arg1 > 18446744073709551615 / arg2) {
            return 0x1::option::none<u64>()
        };
        let v0 = arg1 * arg2;
        if (arg0 > 18446744073709551615 - v0) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(arg0 + v0)
    }

    fun days_from_civil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 <= 2) {
            arg0 - 1
        } else {
            arg0
        };
        let v1 = v0 / 400;
        let v2 = v0 - v1 * 400;
        let v3 = if (arg1 > 2) {
            arg1 - 3
        } else {
            arg1 + 9
        };
        v1 * 146097 + v2 * 365 + v2 / 4 - v2 / 100 + (153 * v3 + 2) / 5 + arg2 - 1 - 719468
    }

    fun days_in_month(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 2) {
            if (is_leap(arg0)) {
                29
            } else {
                28
            }
        } else {
            let v1 = if (arg1 == 4) {
                true
            } else if (arg1 == 6) {
                true
            } else if (arg1 == 9) {
                true
            } else {
                arg1 == 11
            };
            if (v1) {
                30
            } else {
                31
            }
        }
    }

    fun digits_to_u64(arg0: &vector<u8>) : 0x1::option::Option<u64> {
        if (0x1::vector::is_empty<u8>(arg0)) {
            return 0x1::option::none<u64>()
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (v0 > (18446744073709551615 - 9) / 10) {
                return 0x1::option::none<u64>()
            };
            let v2 = v0 * 10;
            v0 = v2 + ((*0x1::vector::borrow<u8>(arg0, v1) - 48) as u64);
            v1 = v1 + 1;
        };
        0x1::option::some<u64>(v0)
    }

    fun fixed_digits(arg0: &vector<u8>, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (arg1 + arg2 > 0x1::vector::length<u8>(arg0)) {
            return 0x1::option::none<u64>()
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = *0x1::vector::borrow<u8>(arg0, arg1 + v1);
            if (!is_digit(v2)) {
                return 0x1::option::none<u64>()
            };
            let v3 = v0 * 10;
            v0 = v3 + ((v2 - 48) as u64);
            v1 = v1 + 1;
        };
        0x1::option::some<u64>(v0)
    }

    fun is_digit(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57
    }

    fun is_leap(arg0: u64) : bool {
        arg0 % 4 == 0 && (arg0 % 100 != 0 || arg0 % 400 == 0)
    }

    public fun ns_per_second() : u64 {
        1000000000
    }

    public fun parse_duration(arg0: &0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::is_empty<u8>(v0) || *0x1::vector::borrow<u8>(v0, 0) != 80) {
            return 0x1::option::none<u64>()
        };
        if (0x1::vector::length<u8>(v0) == 1) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0;
        let v2 = b"";
        let v3 = false;
        let v4 = 1;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(v0)) {
            let v6 = *0x1::vector::borrow<u8>(v0, v4);
            if (v6 == 84 && !v3) {
                if (!0x1::vector::is_empty<u8>(&v2)) {
                    return 0x1::option::none<u64>()
                };
                v3 = true;
                v5 = v4 + 1 == 0x1::vector::length<u8>(v0);
            } else if (is_digit(v6)) {
                0x1::vector::push_back<u8>(&mut v2, v6);
            } else {
                let v7 = digits_to_u64(&v2);
                if (0x1::option::is_none<u64>(&v7)) {
                    return 0x1::option::none<u64>()
                };
                v2 = b"";
                let v8 = if (!v3 && v6 == 87) {
                    604800
                } else if (!v3 && v6 == 68) {
                    86400
                } else if (v3 && v6 == 72) {
                    3600
                } else if (v3 && v6 == 77) {
                    60
                } else if (v3 && v6 == 83) {
                    1
                } else {
                    return 0x1::option::none<u64>()
                };
                let v9 = add_span(v1, 0x1::option::destroy_some<u64>(v7), v8);
                if (0x1::option::is_none<u64>(&v9)) {
                    return 0x1::option::none<u64>()
                };
                v1 = 0x1::option::destroy_some<u64>(v9);
            };
            v4 = v4 + 1;
        };
        if (!0x1::vector::is_empty<u8>(&v2) || v5) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(v1)
    }

    public fun parse_rfc3339(arg0: &0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 20) {
            return 0x1::option::none<u64>()
        };
        let v2 = fixed_digits(v0, 0, 4);
        let v3 = fixed_digits(v0, 5, 2);
        let v4 = fixed_digits(v0, 8, 2);
        let v5 = if (0x1::option::is_none<u64>(&v2)) {
            true
        } else if (0x1::option::is_none<u64>(&v3)) {
            true
        } else {
            0x1::option::is_none<u64>(&v4)
        };
        if (v5) {
            return 0x1::option::none<u64>()
        };
        if (*0x1::vector::borrow<u8>(v0, 4) != 45 || *0x1::vector::borrow<u8>(v0, 7) != 45) {
            return 0x1::option::none<u64>()
        };
        if (*0x1::vector::borrow<u8>(v0, 10) != 84 && *0x1::vector::borrow<u8>(v0, 10) != 116) {
            return 0x1::option::none<u64>()
        };
        let v6 = fixed_digits(v0, 11, 2);
        let v7 = fixed_digits(v0, 14, 2);
        let v8 = fixed_digits(v0, 17, 2);
        let v9 = if (0x1::option::is_none<u64>(&v6)) {
            true
        } else if (0x1::option::is_none<u64>(&v7)) {
            true
        } else {
            0x1::option::is_none<u64>(&v8)
        };
        if (v9) {
            return 0x1::option::none<u64>()
        };
        if (*0x1::vector::borrow<u8>(v0, 13) != 58 || *0x1::vector::borrow<u8>(v0, 16) != 58) {
            return 0x1::option::none<u64>()
        };
        let v10 = 0x1::option::destroy_some<u64>(v2);
        let v11 = 0x1::option::destroy_some<u64>(v3);
        let v12 = 0x1::option::destroy_some<u64>(v4);
        let v13 = 0x1::option::destroy_some<u64>(v6);
        let v14 = 0x1::option::destroy_some<u64>(v7);
        let v15 = 0x1::option::destroy_some<u64>(v8);
        let v16 = if (v10 < 1970) {
            true
        } else if (v11 < 1) {
            true
        } else if (v11 > 12) {
            true
        } else if (v12 < 1) {
            true
        } else {
            v12 > days_in_month(v10, v11)
        };
        if (v16) {
            return 0x1::option::none<u64>()
        };
        let v17 = if (v13 > 23) {
            true
        } else if (v14 > 59) {
            true
        } else {
            v15 > 59
        };
        if (v17) {
            return 0x1::option::none<u64>()
        };
        let v18 = 19;
        let v19 = v18;
        let v20 = 0;
        if (*0x1::vector::borrow<u8>(v0, v18) == 46) {
            v19 = v18 + 1;
            let v21 = 0;
            let v22 = 100000000;
            while (v19 < v1 && is_digit(*0x1::vector::borrow<u8>(v0, v19))) {
                if (v21 >= 9) {
                    return 0x1::option::none<u64>()
                };
                v20 = v20 + ((*0x1::vector::borrow<u8>(v0, v19) - 48) as u64) * v22;
                v22 = v22 / 10;
                v21 = v21 + 1;
                v19 = v19 + 1;
            };
            if (v21 == 0) {
                return 0x1::option::none<u64>()
            };
        };
        if (v19 >= v1) {
            return 0x1::option::none<u64>()
        };
        let v23 = *0x1::vector::borrow<u8>(v0, v19);
        let v24 = 0;
        let v25 = false;
        if (v23 == 90 || v23 == 122) {
            v19 = v19 + 1;
        } else if (v23 == 43 || v23 == 45) {
            let v26 = v23 == 45;
            v25 = v26;
            let v27 = fixed_digits(v0, v19 + 1, 2);
            let v28 = fixed_digits(v0, v19 + 4, 2);
            let v29 = if (0x1::option::is_none<u64>(&v27)) {
                true
            } else if (0x1::option::is_none<u64>(&v28)) {
                true
            } else if (v19 + 3 >= v1) {
                true
            } else {
                *0x1::vector::borrow<u8>(v0, v19 + 3) != 58
            };
            if (v29) {
                return 0x1::option::none<u64>()
            };
            let v30 = 0x1::option::destroy_some<u64>(v27);
            let v31 = 0x1::option::destroy_some<u64>(v28);
            if (v30 > 23 || v31 > 59) {
                return 0x1::option::none<u64>()
            };
            let v32 = if (v26) {
                if (v30 == 0) {
                    v31 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v32) {
                return 0x1::option::none<u64>()
            };
            v24 = v30 * 3600 + v31 * 60;
            v19 = v19 + 6;
        } else {
            return 0x1::option::none<u64>()
        };
        if (v19 != v1) {
            return 0x1::option::none<u64>()
        };
        let v33 = days_from_civil(v10, v11, v12) * 86400 + v13 * 3600 + v14 * 60 + v15;
        let v34 = if (v25) {
            v33 + v24
        } else {
            if (v33 < v24) {
                return 0x1::option::none<u64>()
            };
            v33 - v24
        };
        if (v34 > (18446744073709551615 - v20) / 1000000000) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(v34 * 1000000000 + v20)
    }

    // decompiled from Move bytecode v7
}

