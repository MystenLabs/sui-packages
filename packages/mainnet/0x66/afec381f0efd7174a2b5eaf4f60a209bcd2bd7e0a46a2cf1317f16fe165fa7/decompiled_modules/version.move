module 0x66afec381f0efd7174a2b5eaf4f60a209bcd2bd7e0a46a2cf1317f16fe165fa7::version {
    public fun next_version() : u64 {
        0x66afec381f0efd7174a2b5eaf4f60a209bcd2bd7e0a46a2cf1317f16fe165fa7::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x66afec381f0efd7174a2b5eaf4f60a209bcd2bd7e0a46a2cf1317f16fe165fa7::constants::version(), 0x66afec381f0efd7174a2b5eaf4f60a209bcd2bd7e0a46a2cf1317f16fe165fa7::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x66afec381f0efd7174a2b5eaf4f60a209bcd2bd7e0a46a2cf1317f16fe165fa7::constants::version()
    }

    // decompiled from Move bytecode v7
}

