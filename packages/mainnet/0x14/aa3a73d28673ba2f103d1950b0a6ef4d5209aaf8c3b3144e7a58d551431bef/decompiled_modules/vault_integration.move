module 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::vault_integration {
    struct Balances has copy, drop {
        x: u64,
        y: u64,
    }

    struct Signed has copy, drop {
        abs: u128,
        neg: bool,
    }

    struct Swap has copy, drop {
        amount_in: u64,
        amount_out: u64,
        side: bool,
        supply: u64,
        debt: u64,
        ref_sqrtprice: u128,
        e_minus_one: u128,
        qt: u128,
        fee: u128,
    }

    public fun deviation(arg0: u128, arg1: u64, arg2: u64, arg3: u128) : Signed {
        let v0 = 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(arg0, arg0), 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(arg1)), 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(arg2));
        if (v0 >= arg3) {
            Signed{abs: 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(v0, arg3) - 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(1), neg: false}
        } else {
            Signed{abs: 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(1) - 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(v0, arg3), neg: true}
        }
    }

    public fun emit_swap(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u128, arg8: u128) {
        let v0 = Swap{
            amount_in     : arg0,
            amount_out    : arg1,
            side          : arg2,
            supply        : arg3,
            debt          : arg4,
            ref_sqrtprice : arg5,
            e_minus_one   : arg6,
            qt            : arg7,
            fee           : arg8,
        };
        0x2::event::emit<Swap>(v0);
    }

    public fun emit_virtual_balances(arg0: u128, arg1: u64, arg2: u128, arg3: u128) {
        let v0 = liquidity(arg0, arg1, arg2, arg3);
        let v1 = Balances{
            x : 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::floor(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(v0, arg0)),
            y : 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::floor(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(v0, arg0)),
        };
        0x2::event::emit<Balances>(v1);
    }

    public fun liquidity(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : u128 {
        0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(2), arg3), arg2 - 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(1)), arg0), 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(arg1))
    }

    public fun vault_sqrtprice(arg0: u128, arg1: Signed, arg2: u128) : u128 {
        let v0 = if (arg1.neg) {
            0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(1) - (0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(arg2, arg1.abs) >> 1)
        } else {
            0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::to_128(1) + (0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(arg2, arg1.abs) >> 1)
        };
        0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(arg0, v0)
    }

    public fun virtual_balances(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : Balances {
        let v0 = liquidity(arg0, arg1, arg2, arg3);
        Balances{
            x : 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::floor(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::div_128(v0, arg0)),
            y : 0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::floor(0x14aa3a73d28673ba2f103d1950b0a6ef4d5209aaf8c3b3144e7a58d551431bef::arithmetic::mul_128(v0, arg0)),
        }
    }

    // decompiled from Move bytecode v6
}

