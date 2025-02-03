module 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

