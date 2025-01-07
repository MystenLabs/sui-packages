module 0x54d3ed2e8a37a1f5be4e9f6534590421c32a641152b13b08d332f52294c33eba::main {
    public fun calc_input_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg2 > 0, 0);
        assert!(arg1 > arg2, 0);
        assert!(arg3 < arg4, 0);
        (((arg0 as u256) * (arg2 as u256) * (arg4 as u256) / ((arg1 - arg2) as u256) * (arg3 as u256) + 1) as u64)
    }

    // decompiled from Move bytecode v6
}

