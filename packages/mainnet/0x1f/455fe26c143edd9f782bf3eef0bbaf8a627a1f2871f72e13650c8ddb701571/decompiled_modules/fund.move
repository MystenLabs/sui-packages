module 0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::fund {
    struct Fund has copy, drop, store {
        shares: u128,
        underlying: u128,
    }

    public fun empty() : Fund {
        Fund{
            shares     : 0,
            underlying : 0,
        }
    }

    public fun add_profit(arg0: &mut Fund, arg1: u64) {
        arg0.underlying = arg0.underlying + (arg1 as u128);
    }

    public fun add_underlying(arg0: &mut Fund, arg1: u64, arg2: bool) : u64 {
        let v0 = to_shares(arg0, arg1, arg2);
        arg0.underlying = arg0.underlying + (arg1 as u128);
        arg0.shares = arg0.shares + (v0 as u128);
        v0
    }

    public fun shares(arg0: &Fund) : u64 {
        (arg0.shares as u64)
    }

    public fun sub_shares(arg0: &mut Fund, arg1: u64, arg2: bool) : u64 {
        let v0 = to_underlying(arg0, arg1, arg2);
        arg0.underlying = arg0.underlying - (v0 as u128);
        arg0.shares = arg0.shares - (arg1 as u128);
        v0
    }

    public fun sub_underlying(arg0: &mut Fund, arg1: u64, arg2: bool) : u64 {
        let v0 = to_shares(arg0, arg1, arg2);
        arg0.underlying = arg0.underlying - (arg1 as u128);
        arg0.shares = arg0.shares - (v0 as u128);
        v0
    }

    public fun to_shares(arg0: &Fund, arg1: u64, arg2: bool) : u64 {
        if (arg0.underlying == 0) {
            return arg1
        };
        if (arg2) {
            (0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::math128::mul_div_up((arg1 as u128), arg0.shares, arg0.underlying) as u64)
        } else {
            (0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::math128::mul_div_down((arg1 as u128), arg0.shares, arg0.underlying) as u64)
        }
    }

    public fun to_underlying(arg0: &Fund, arg1: u64, arg2: bool) : u64 {
        if (arg0.shares == 0) {
            return arg1
        };
        if (arg2) {
            (0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::math128::mul_div_up((arg1 as u128), arg0.underlying, arg0.shares) as u64)
        } else {
            (0x1f455fe26c143edd9f782bf3eef0bbaf8a627a1f2871f72e13650c8ddb701571::math128::mul_div_down((arg1 as u128), arg0.underlying, arg0.shares) as u64)
        }
    }

    public fun underlying(arg0: &Fund) : u64 {
        (arg0.underlying as u64)
    }

    // decompiled from Move bytecode v6
}

