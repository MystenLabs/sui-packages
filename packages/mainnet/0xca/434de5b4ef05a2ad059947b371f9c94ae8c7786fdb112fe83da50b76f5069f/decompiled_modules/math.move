module 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::math {
    public(friend) fun abs_diff(arg0: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        if (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::ge(arg0, arg1)) {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(arg0, arg1)
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::sub(arg1, arg0)
        }
    }

    public(friend) fun checked_mul_div(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (arg2 == 0) {
            return 0x1::option::none<u64>()
        };
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        if (v0 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v0 as u64))
    }

    public(friend) fun checked_mul_div_up(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (arg2 == 0) {
            return 0x1::option::none<u64>()
        };
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg2 as u128);
        let v2 = if (v0 % v1 == 0) {
            v0 / v1
        } else {
            v0 / v1 + 1
        };
        if (v2 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v2 as u64))
    }

    public(friend) fun min_non_zero(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 == 0 && arg1 == 0;
        assert!(!v0, 2);
        if (arg0 == 0) {
            return arg1
        };
        if (arg1 == 0) {
            return arg0
        };
        0x1::u64::min(arg0, arg1)
    }

    public(friend) fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public(friend) fun safe_mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg2 as u128);
        let v2 = if (v0 % v1 == 0) {
            v0 / v1
        } else {
            v0 / v1 + 1
        };
        assert!(v2 <= 18446744073709551615, 0);
        (v2 as u64)
    }

    // decompiled from Move bytecode v6
}

