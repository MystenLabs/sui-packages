module 0x825b0b75efc9e37ce6268890e78e078591d8826dd9fcdde1adee6201399df182::dice_interpreter {
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

