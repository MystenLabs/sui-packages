module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9_convert {
    public fun from_u128(arg0: u128, arg1: bool) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        assert!(arg0 <= 170141183460469231731687303715, 13835058321570136065);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(arg0 * 1000000000, arg1)
    }

    public fun from_u64(arg0: u64, arg1: bool) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        from_u128((arg0 as u128), arg1)
    }

    public fun to_parts_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : (u128, bool) {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0);
        let (v1, v2) = if (v0 & 170141183460469231731687303715884105728 != 0) {
            (true, 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::two_complement(v0))
        } else {
            (false, v0)
        };
        let v3 = v2 / 1000000000;
        let v4 = v1 && v3 != 0;
        (v3, v4)
    }

    public fun to_u128_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : u128 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0);
        assert!(v0 & 170141183460469231731687303715884105728 == 0, 13835340045655080963);
        v0 / 1000000000
    }

    public fun to_u64_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : u64 {
        let v0 = to_u128_trunc(arg0);
        assert!(v0 <= 18446744073709551615, 13835621670955778053);
        (v0 as u64)
    }

    public fun try_from_u128(arg0: u128, arg1: bool) : 0x1::option::Option<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9> {
        if (arg0 > 170141183460469231731687303715) {
            0x1::option::none<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9>()
        } else {
            0x1::option::some<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9>(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(arg0 * 1000000000, arg1))
        }
    }

    public fun try_to_u128_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0x1::option::Option<u128> {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0);
        if (v0 & 170141183460469231731687303715884105728 != 0) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(v0 / 1000000000)
        }
    }

    public fun try_to_u64_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0x1::option::Option<u64> {
        let v0 = try_to_u128_trunc(arg0);
        if (0x1::option::is_none<u128>(&v0)) {
            0x1::option::none<u64>()
        } else {
            let v2 = 0x1::option::destroy_some<u128>(v0);
            if (v2 > 18446744073709551615) {
                0x1::option::none<u64>()
            } else {
                0x1::option::some<u64>((v2 as u64))
            }
        }
    }

    // decompiled from Move bytecode v7
}

