module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper {
    public fun is_sorted<T0, T1>() : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::ascii::as_bytes(&v2);
        if (0x1::vector::length<u8>(v1) < 0x1::vector::length<u8>(v3)) {
            return true
        };
        if (0x1::vector::length<u8>(v1) > 0x1::vector::length<u8>(v3)) {
            return false
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v1)) {
            let v5 = *0x1::vector::borrow<u8>(v1, v4);
            let v6 = *0x1::vector::borrow<u8>(v3, v4);
            if (v5 == v6) {
                v4 = v4 + 1;
                continue
            };
            if (v5 < v6) {
                return true
            };
            return false
        };
        true
    }

    public fun is_valid_curve_fee(arg0: u64) : bool {
        1 <= arg0 && arg0 <= 1000
    }

    public fun is_valid_dao_fee(arg0: u64) : bool {
        0 <= arg0 && arg0 <= 100
    }

    // decompiled from Move bytecode v6
}

