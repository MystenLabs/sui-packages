module 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::vault_integration {
    struct Balances has copy, drop {
        x: u64,
        y: u64,
    }

    public fun deviation(arg0: u128, arg1: u64, arg2: u64, arg3: u128) : u128 {
        0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(arg0, arg0), 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(arg1)), 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(arg2)), arg3) - 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(1)
    }

    public fun emit_virtual_balances(arg0: u128, arg1: u64, arg2: u128, arg3: u128) {
        let v0 = liquidity(arg0, arg1, arg2, arg3);
        let v1 = Balances{
            x : 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::floor(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(v0, arg0)),
            y : 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::floor(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(v0, arg0)),
        };
        0x2::event::emit<Balances>(v1);
    }

    public fun liquidity(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : u128 {
        0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(2), arg3), arg2 - 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(1)), arg0), 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(arg1))
    }

    public fun vault_sqrtprice(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(arg0, 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(1) + (0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(arg2, arg1) >> 1))
    }

    public fun virtual_balances(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : Balances {
        let v0 = liquidity(arg0, arg1, arg2, arg3);
        Balances{
            x : 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::floor(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(v0, arg0)),
            y : 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::floor(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(v0, arg0)),
        }
    }

    // decompiled from Move bytecode v6
}

