module 0xacd1587237cacbcfe50cf1cee163fe73472862fdc337455b1da859a42afc1021::version {
    public fun next_version() : u64 {
        0xacd1587237cacbcfe50cf1cee163fe73472862fdc337455b1da859a42afc1021::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xacd1587237cacbcfe50cf1cee163fe73472862fdc337455b1da859a42afc1021::constants::version(), 0xacd1587237cacbcfe50cf1cee163fe73472862fdc337455b1da859a42afc1021::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xacd1587237cacbcfe50cf1cee163fe73472862fdc337455b1da859a42afc1021::constants::version()
    }

    // decompiled from Move bytecode v6
}

