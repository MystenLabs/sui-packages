module 0x1::fixed_point32 {
    struct FixedPoint32 has copy, drop, store {
        value: u64,
    }

    public fun create_from_rational(arg0: u64, arg1: u64) : FixedPoint32 {
        let v0 = (arg1 as u128) << 32;
        assert!(v0 != 0, 65537);
        let v1 = ((arg0 as u128) << 64) / v0;
        assert!(v1 != 0 || arg0 == 0, 131077);
        assert!(v1 <= 18446744073709551615, 131077);
        FixedPoint32{value: (v1 as u64)}
    }

    public fun create_from_raw_value(arg0: u64) : FixedPoint32 {
        FixedPoint32{value: arg0}
    }

    public fun divide_u64(arg0: u64, arg1: FixedPoint32) : u64 {
        assert!(arg1.value != 0, 65540);
        let v0 = ((arg0 as u128) << 32) / (arg1.value as u128);
        assert!(v0 <= 18446744073709551615, 131074);
        (v0 as u64)
    }

    public fun get_raw_value(arg0: FixedPoint32) : u64 {
        arg0.value
    }

    public fun is_zero(arg0: FixedPoint32) : bool {
        arg0.value == 0
    }

    public fun multiply_u64(arg0: u64, arg1: FixedPoint32) : u64 {
        let v0 = (arg0 as u128) * (arg1.value as u128) >> 32;
        assert!(v0 <= 18446744073709551615, 131075);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

