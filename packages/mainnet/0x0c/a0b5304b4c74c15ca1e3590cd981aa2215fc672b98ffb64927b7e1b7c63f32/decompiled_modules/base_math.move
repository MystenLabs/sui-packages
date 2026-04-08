module 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::base_math {
    public(friend) fun abs_diff(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg1: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal {
        if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::ge(arg0, arg1)) {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::sub(arg0, arg1)
        } else {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::sub(arg1, arg0)
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
        let (v0, v1) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::math128::try_mul_div_up((arg0 as u128), (arg1 as u128), (arg2 as u128));
        if (!v0 || v1 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((v1 as u64))
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
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::math128::mul_div_up((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

