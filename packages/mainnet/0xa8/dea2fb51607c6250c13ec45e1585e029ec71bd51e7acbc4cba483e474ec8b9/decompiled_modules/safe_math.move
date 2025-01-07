module 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

