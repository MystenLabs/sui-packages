module 0x24a6212877f81a78c04b47717ee41a4741430b9635f22f84006a6b1a2399ea81::version {
    public fun next_version() : u64 {
        0x24a6212877f81a78c04b47717ee41a4741430b9635f22f84006a6b1a2399ea81::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x24a6212877f81a78c04b47717ee41a4741430b9635f22f84006a6b1a2399ea81::constants::version(), 0x24a6212877f81a78c04b47717ee41a4741430b9635f22f84006a6b1a2399ea81::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x24a6212877f81a78c04b47717ee41a4741430b9635f22f84006a6b1a2399ea81::constants::version()
    }

    // decompiled from Move bytecode v6
}

