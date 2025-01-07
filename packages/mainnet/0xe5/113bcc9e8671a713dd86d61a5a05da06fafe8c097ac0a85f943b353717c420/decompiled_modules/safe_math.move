module 0xe5113bcc9e8671a713dd86d61a5a05da06fafe8c097ac0a85f943b353717c420::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

