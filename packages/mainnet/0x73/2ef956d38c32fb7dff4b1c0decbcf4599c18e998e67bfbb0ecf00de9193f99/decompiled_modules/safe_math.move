module 0x732ef956d38c32fb7dff4b1c0decbcf4599c18e998e67bfbb0ecf00de9193f99::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

