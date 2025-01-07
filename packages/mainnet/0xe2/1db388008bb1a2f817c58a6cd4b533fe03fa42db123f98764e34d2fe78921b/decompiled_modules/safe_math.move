module 0xe21db388008bb1a2f817c58a6cd4b533fe03fa42db123f98764e34d2fe78921b::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

