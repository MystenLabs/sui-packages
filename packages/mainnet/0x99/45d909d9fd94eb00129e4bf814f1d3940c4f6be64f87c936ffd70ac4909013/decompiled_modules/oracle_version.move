module 0x9945d909d9fd94eb00129e4bf814f1d3940c4f6be64f87c936ffd70ac4909013::oracle_version {
    public fun next_version() : u64 {
        0x9945d909d9fd94eb00129e4bf814f1d3940c4f6be64f87c936ffd70ac4909013::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x9945d909d9fd94eb00129e4bf814f1d3940c4f6be64f87c936ffd70ac4909013::oracle_constants::version(), 0x9945d909d9fd94eb00129e4bf814f1d3940c4f6be64f87c936ffd70ac4909013::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x9945d909d9fd94eb00129e4bf814f1d3940c4f6be64f87c936ffd70ac4909013::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

