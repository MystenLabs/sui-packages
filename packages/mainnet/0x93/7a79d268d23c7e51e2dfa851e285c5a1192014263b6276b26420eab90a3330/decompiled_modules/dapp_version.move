module 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::dapp_version {
    public fun check_version(arg0: u64) {
        assert!(get_version() == arg0, 1001);
    }

    public fun get_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

