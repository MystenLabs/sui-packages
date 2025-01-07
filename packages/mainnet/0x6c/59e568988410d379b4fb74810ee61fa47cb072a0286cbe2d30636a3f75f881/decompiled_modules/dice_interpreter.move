module 0x6c59e568988410d379b4fb74810ee61fa47cb072a0286cbe2d30636a3f75f881::dice_interpreter {
    public fun get_dice(arg0: u64) : (u64, u64) {
        assert!(arg0 >= 0 && arg0 < 36, 0);
        (arg0 / 6 + 1, arg0 % 6 + 1)
    }

    public fun get_dice_sum(arg0: u64) : u64 {
        let (v0, v1) = get_dice(arg0);
        v0 + v1
    }

    // decompiled from Move bytecode v6
}

