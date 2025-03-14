module 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::utils {
    public fun asset_to_sy(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : u64 {
        (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::divide_u128((arg0 as u128), arg1) as u64)
    }

    public fun cmp_type_names(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) : u8 {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(arg0));
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(arg1));
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v1);
        let v4 = 0;
        while (v4 < 0x1::u64::min(v2, v3)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v4);
            let v6 = *0x1::vector::borrow<u8>(v1, v4);
            if (v5 < v6) {
                return 0
            };
            if (v5 > v6) {
                return 2
            };
            v4 = v4 + 1;
        };
        if (v2 == v3) {
            1
        } else if (v2 < v3) {
            0
        } else {
            2
        }
    }

    public fun mulsqrt_u64(arg0: u64, arg1: u64) : u64 {
        (0x1::u128::sqrt((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun sy_to_asset(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) : u64 {
        (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128((arg0 as u128), arg1) as u64)
    }

    // decompiled from Move bytecode v6
}

