module 0xed7d6d95b4bc0fd62cbee7d36bcdf05793768b8ab97350bbe85b54faee8de02e::utils {
    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

