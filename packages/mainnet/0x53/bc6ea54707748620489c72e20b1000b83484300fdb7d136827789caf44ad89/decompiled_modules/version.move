module 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::version {
    public(friend) fun assert_version_compatibility(arg0: u8) {
        assert!(arg0 == 1, 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::errors::version_mismatch());
    }

    public(friend) fun is_compatible(arg0: u8) : bool {
        arg0 == 1
    }

    public fun package_version() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

