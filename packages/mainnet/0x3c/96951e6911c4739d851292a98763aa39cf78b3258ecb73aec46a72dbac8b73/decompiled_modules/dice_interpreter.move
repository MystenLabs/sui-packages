module 0x3c96951e6911c4739d851292a98763aa39cf78b3258ecb73aec46a72dbac8b73::dice_interpreter {
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

