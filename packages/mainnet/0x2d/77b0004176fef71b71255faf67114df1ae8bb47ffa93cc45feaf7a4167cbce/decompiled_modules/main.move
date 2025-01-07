module 0x2d77b0004176fef71b71255faf67114df1ae8bb47ffa93cc45feaf7a4167cbce::main {
    public fun calc_input_amount(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : u256 {
        assert!(arg2 > 0, 0);
        assert!(arg1 > arg2, 0);
        assert!(arg3 < arg4, 0);
        arg0 * arg2 * (arg4 as u256) / (arg1 - arg2) * (arg3 as u256) + 1
    }

    // decompiled from Move bytecode v6
}

