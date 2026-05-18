module 0xebd5dc10b1960dad9a7aa25a214f4a9f538053a7a477f99cf7af4113cf95c872::version {
    public fun next_version() : u64 {
        0xebd5dc10b1960dad9a7aa25a214f4a9f538053a7a477f99cf7af4113cf95c872::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xebd5dc10b1960dad9a7aa25a214f4a9f538053a7a477f99cf7af4113cf95c872::constants::version(), 0xebd5dc10b1960dad9a7aa25a214f4a9f538053a7a477f99cf7af4113cf95c872::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xebd5dc10b1960dad9a7aa25a214f4a9f538053a7a477f99cf7af4113cf95c872::constants::version()
    }

    // decompiled from Move bytecode v7
}

