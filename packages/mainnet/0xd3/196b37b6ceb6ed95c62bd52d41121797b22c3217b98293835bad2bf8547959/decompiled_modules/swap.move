module 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::swap {
    public fun exact_in(arg0: bool, arg1: u64, arg2: u128, arg3: u128) : (u64, u128) {
        if (arg0) {
            let v2 = 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(arg3, 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(arg3, arg2) + 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(arg1));
            (0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::floor(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(arg3, arg2 - v2)), v2)
        } else {
            let v3 = 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::mul_128(arg3, arg2) + 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::to_128(arg1), arg3);
            (0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::floor(0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(arg3, arg2) - 0xd3196b37b6ceb6ed95c62bd52d41121797b22c3217b98293835bad2bf8547959::arithmetic::div_128(arg3, v3)), v3)
        }
    }

    // decompiled from Move bytecode v6
}

