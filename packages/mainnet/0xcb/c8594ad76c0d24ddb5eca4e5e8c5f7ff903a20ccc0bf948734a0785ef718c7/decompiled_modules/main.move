module 0xcbc8594ad76c0d24ddb5eca4e5e8c5f7ff903a20ccc0bf948734a0785ef718c7::main {
    public fun calc_input_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg2 > 0, 0);
        assert!(arg1 > arg2, 0);
        assert!(arg3 < arg4, 0);
        (((arg0 as u128) * (arg2 as u128) * (arg4 as u128) / ((arg1 - arg2) as u128) * (arg3 as u128)) as u64) + 1
    }

    // decompiled from Move bytecode v6
}

