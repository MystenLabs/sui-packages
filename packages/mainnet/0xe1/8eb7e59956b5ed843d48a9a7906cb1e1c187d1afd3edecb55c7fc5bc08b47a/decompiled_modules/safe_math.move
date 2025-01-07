module 0xe18eb7e59956b5ed843d48a9a7906cb1e1c187d1afd3edecb55c7fc5bc08b47a::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

