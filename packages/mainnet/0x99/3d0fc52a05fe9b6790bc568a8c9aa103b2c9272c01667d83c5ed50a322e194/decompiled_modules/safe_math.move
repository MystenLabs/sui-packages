module 0x993d0fc52a05fe9b6790bc568a8c9aa103b2c9272c01667d83c5ed50a322e194::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

