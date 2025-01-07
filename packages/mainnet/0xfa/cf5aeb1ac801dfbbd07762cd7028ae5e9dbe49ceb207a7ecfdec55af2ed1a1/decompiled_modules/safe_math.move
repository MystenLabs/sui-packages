module 0xfacf5aeb1ac801dfbbd07762cd7028ae5e9dbe49ceb207a7ecfdec55af2ed1a1::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

