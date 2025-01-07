module 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

