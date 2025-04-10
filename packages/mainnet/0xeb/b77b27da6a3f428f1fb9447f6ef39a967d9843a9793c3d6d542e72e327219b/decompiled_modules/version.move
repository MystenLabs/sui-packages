module 0xef5a7d383807b18befb9028e51ad4a7a4c4cc4158a01440677a0d09d6542b72f::version {
    struct Version has store {
        version: u16,
    }

    public(friend) fun check_version(arg0: &Version) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun get_version(arg0: &Version) : u16 {
        arg0.version
    }

    public(friend) fun increment_version(arg0: &mut Version) {
        arg0.version = arg0.version + 1;
    }

    public(friend) fun init_version() : Version {
        Version{version: 1}
    }

    // decompiled from Move bytecode v6
}

