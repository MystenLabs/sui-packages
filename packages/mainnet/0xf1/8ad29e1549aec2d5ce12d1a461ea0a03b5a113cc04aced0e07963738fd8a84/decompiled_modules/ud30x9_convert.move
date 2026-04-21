module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9_convert {
    public fun from_u128(arg0: u128) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        assert!(arg0 <= 340282366920938463463374607431, 13835058265735561217);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(arg0 * 1000000000)
    }

    public fun from_u64(arg0: u64) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        from_u128((arg0 as u128))
    }

    public fun to_u128_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : u128 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) / 1000000000
    }

    public fun to_u64_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : u64 {
        let v0 = to_u128_trunc(arg0);
        assert!(v0 <= 18446744073709551615, 13835339942575865859);
        (v0 as u64)
    }

    public fun try_from_u128(arg0: u128) : 0x1::option::Option<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9> {
        if (arg0 > 340282366920938463463374607431) {
            0x1::option::none<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9>()
        } else {
            0x1::option::some<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9>(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(arg0 * 1000000000))
        }
    }

    public fun try_to_u64_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0x1::option::Option<u64> {
        let v0 = to_u128_trunc(arg0);
        if (v0 > 18446744073709551615) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((v0 as u64))
        }
    }

    // decompiled from Move bytecode v7
}

