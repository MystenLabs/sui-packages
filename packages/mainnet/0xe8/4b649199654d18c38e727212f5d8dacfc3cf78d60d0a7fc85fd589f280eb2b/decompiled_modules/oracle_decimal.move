module 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal {
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

