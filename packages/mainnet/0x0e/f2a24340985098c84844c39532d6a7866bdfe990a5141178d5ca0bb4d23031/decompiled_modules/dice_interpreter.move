module 0xef2a24340985098c84844c39532d6a7866bdfe990a5141178d5ca0bb4d23031::dice_interpreter {
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

