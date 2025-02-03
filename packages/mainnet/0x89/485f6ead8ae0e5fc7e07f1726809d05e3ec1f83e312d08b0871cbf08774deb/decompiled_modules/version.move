module 0x66648edaf473d6cc14b7ab46f56b673be4e44f9c940f70b6bacd7848808859b::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::version_mismatch_error());
    }

    public fun block(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0;
    }

    fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x66648edaf473d6cc14b7ab46f56b673be4e44f9c940f70b6bacd7848808859b::current_version::current_version()
    }

    public fun update(arg0: &mut Version, arg1: &VersionCap) {
        assert!(arg0.value < 0x66648edaf473d6cc14b7ab46f56b673be4e44f9c940f70b6bacd7848808859b::current_version::current_version(), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::version_mismatch_error());
        arg0.value = 0x66648edaf473d6cc14b7ab46f56b673be4e44f9c940f70b6bacd7848808859b::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

