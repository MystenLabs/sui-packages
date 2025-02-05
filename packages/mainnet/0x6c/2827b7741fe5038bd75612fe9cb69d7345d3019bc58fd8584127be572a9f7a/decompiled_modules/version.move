module 0x6c2827b7741fe5038bd75612fe9cb69d7345d3019bc58fd8584127be572a9f7a::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::version_mismatch_error());
    }

    public fun block(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0;
    }

    fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x6c2827b7741fe5038bd75612fe9cb69d7345d3019bc58fd8584127be572a9f7a::current_version::current_version()
    }

    public fun update(arg0: &mut Version, arg1: &VersionCap) {
        assert!(arg0.value < 0x6c2827b7741fe5038bd75612fe9cb69d7345d3019bc58fd8584127be572a9f7a::current_version::current_version(), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::version_mismatch_error());
        arg0.value = 0x6c2827b7741fe5038bd75612fe9cb69d7345d3019bc58fd8584127be572a9f7a::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

