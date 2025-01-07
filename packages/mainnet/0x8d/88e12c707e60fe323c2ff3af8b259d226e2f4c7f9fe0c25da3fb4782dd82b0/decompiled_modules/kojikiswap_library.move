module 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library {
    public fun compare<T0, T1>() : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = 0x1::ascii::length(&v0);
        let v3 = 0x1::ascii::length(&v1);
        let v4 = 0x1::ascii::into_bytes(v0);
        let v5 = 0x1::ascii::into_bytes(v1);
        if (v2 < v3) {
            return true
        };
        if (v2 > v3) {
            return false
        } else {
            let v6 = 0;
            while (v6 < v2) {
                let v7 = *0x1::vector::borrow<u8>(&v4, v6);
                let v8 = *0x1::vector::borrow<u8>(&v5, v6);
                if (v7 < v8) {
                    return true
                };
                if (v7 > v8) {
                    return false
                };
                v6 = v6 + 1;
            };
            abort 205
        };
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 204);
        assert!(arg1 > 0 && arg2 > 0, 202);
        (((arg1 as u128) * (arg0 as u128) * 10000 / ((arg2 - arg0) as u128) * ((10000 - arg3) as u128) + 1) as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 203);
        assert!(arg1 > 0 && arg2 > 0, 202);
        let v0 = (arg0 as u128) * ((10000 - arg3) as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    public fun is_overflow_mul(arg0: u128, arg1: u128) : bool {
        340282366920938463463374607431768211455 / arg1 <= arg0
    }

    public fun overflow_add(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455 - arg1;
        if (v0 < arg0) {
            return arg0 - v0 - 1
        };
        let v1 = 340282366920938463463374607431768211455 - arg0;
        if (v1 < arg1) {
            return arg1 - v1 - 1
        };
        arg0 + arg1
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 201);
        assert!(arg1 > 0 && arg2 > 0, 202);
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public fun sqrt(arg0: u64, arg1: u64) : u64 {
        (0x2::math::sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

