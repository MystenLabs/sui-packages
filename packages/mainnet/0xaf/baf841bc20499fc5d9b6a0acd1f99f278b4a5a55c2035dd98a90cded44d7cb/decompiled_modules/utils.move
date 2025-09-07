module 0xafbaf841bc20499fc5d9b6a0acd1f99f278b4a5a55c2035dd98a90cded44d7cb::utils {
    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

