module 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::math {
    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 1000000;
        if (v0 > 18446744073709551615) {
            abort 1
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

