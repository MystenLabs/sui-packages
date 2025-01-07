module 0x66e27bd6cd50c34933c9a5e282b69b5c3609db4d9938597658187070a114902c::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

