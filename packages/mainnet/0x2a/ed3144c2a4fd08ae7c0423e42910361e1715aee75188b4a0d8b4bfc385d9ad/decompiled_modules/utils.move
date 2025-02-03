module 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

