module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::threshold {
    public(friend) fun certificate_threshold(arg0: u64) : u64 {
        weight_threshold(arg0, 6667)
    }

    public(friend) fun weight_threshold(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 13906834328962334723);
        0x1::u64::divide_and_round_up(arg0 * arg1, 10000)
    }

    // decompiled from Move bytecode v7
}

