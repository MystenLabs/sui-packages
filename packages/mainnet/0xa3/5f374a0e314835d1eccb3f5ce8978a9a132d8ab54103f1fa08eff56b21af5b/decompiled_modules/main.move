module 0xa35f374a0e314835d1eccb3f5ce8978a9a132d8ab54103f1fa08eff56b21af5b::main {
    public fun calc_input_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg2 > 0, 0);
        assert!(arg1 > arg2, 0);
        assert!(arg3 < arg4, 0);
        (((arg0 as u256) * (arg2 as u256) * (arg4 as u256) / ((arg1 - arg2) as u256) * ((arg4 - arg3) as u256) + 1) as u64)
    }

    // decompiled from Move bytecode v6
}

