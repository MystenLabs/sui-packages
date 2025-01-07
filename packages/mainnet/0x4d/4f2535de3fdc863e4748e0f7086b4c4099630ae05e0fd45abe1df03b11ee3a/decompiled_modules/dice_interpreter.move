module 0xb2f8a9706809c27e1afbe42b1713ad9f7792de276f8c0e4de504868ed402e274::dice_interpreter {
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

