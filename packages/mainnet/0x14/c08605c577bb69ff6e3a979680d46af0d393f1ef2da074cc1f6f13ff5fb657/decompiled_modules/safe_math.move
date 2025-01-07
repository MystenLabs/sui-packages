module 0x14c08605c577bb69ff6e3a979680d46af0d393f1ef2da074cc1f6f13ff5fb657::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

