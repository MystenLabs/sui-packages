module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

