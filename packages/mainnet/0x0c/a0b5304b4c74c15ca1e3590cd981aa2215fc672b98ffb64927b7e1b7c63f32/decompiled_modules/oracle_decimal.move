module 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracle_decimal {
    struct OracleDecimal has copy, drop, store {
        base: u128,
        expo: u64,
        is_expo_negative: bool,
    }

    public fun base(arg0: &OracleDecimal) : u128 {
        arg0.base
    }

    public fun expo(arg0: &OracleDecimal) : u64 {
        arg0.expo
    }

    public fun is_expo_negative(arg0: &OracleDecimal) : bool {
        arg0.is_expo_negative
    }

    public fun new(arg0: u128, arg1: u64, arg2: bool) : OracleDecimal {
        OracleDecimal{
            base             : arg0,
            expo             : arg1,
            is_expo_negative : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

