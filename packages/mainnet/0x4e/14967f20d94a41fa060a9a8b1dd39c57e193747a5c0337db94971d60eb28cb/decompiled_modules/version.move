module 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::version {
    public(friend) fun assert_version_compatibility(arg0: u8) {
        assert!(arg0 == 1, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::errors::version_mismatch());
    }

    public(friend) fun is_compatible(arg0: u8) : bool {
        arg0 == 1
    }

    public fun package_version() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

