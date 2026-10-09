module 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::launch_math {
    public fun cooldown_over(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 == 0) {
            true
        } else if (arg1 == arg0) {
            true
        } else {
            arg1 - arg0 >= arg2
        }
    }

    public fun is_valid_link(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0) {
            return true
        };
        if (v1 > 200 || v1 <= 8) {
            return false
        };
        let v2 = b"https://";
        let v3 = 0;
        while (v3 < 8) {
            if (*0x1::vector::borrow<u8>(v0, v3) != *0x1::vector::borrow<u8>(&v2, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            let v5 = if (v4 <= 32) {
                true
            } else if (v4 == 34) {
                true
            } else if (v4 == 39) {
                true
            } else if (v4 == 60) {
                true
            } else if (v4 == 62) {
                true
            } else if (v4 == 92) {
                true
            } else {
                v4 == 127
            };
            if (v5) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public fun launch_times(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = if (arg1 > arg0) {
            arg1
        } else {
            arg0
        };
        let v1 = v0 + arg2;
        let v2 = if (arg3 > 0 && arg3 < v1) {
            arg3
        } else {
            v1
        };
        (v0, v2)
    }

    public fun token_first<T0, T1>() : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = 0x1::vector::length<u8>(&v1);
        let v4 = 0;
        while (v4 < v2 && v4 < v3) {
            if (*0x1::vector::borrow<u8>(&v0, v4) != *0x1::vector::borrow<u8>(&v1, v4)) {
                return *0x1::vector::borrow<u8>(&v0, v4) > *0x1::vector::borrow<u8>(&v1, v4)
            };
            v4 = v4 + 1;
        };
        v2 > v3
    }

    // decompiled from Move bytecode v7
}

