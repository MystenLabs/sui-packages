module 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::version {
    public(friend) fun assert_version_compatibility(arg0: u8) {
        assert!(arg0 == 1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::version_mismatch());
    }

    public(friend) fun is_compatible(arg0: u8) : bool {
        arg0 == 1
    }

    public fun package_version() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

