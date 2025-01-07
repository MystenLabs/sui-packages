module 0x6d1d7ba273643a1e1b00eda91a881df8f1efa1ecabc47bdc62ec689e2f01bd3d::version {
    struct Version has store {
        version: u16,
    }

    public(friend) fun check_version(arg0: &Version) {
        assert!(arg0.version == 2, 0);
    }

    public(friend) fun get_version(arg0: &Version) : u16 {
        arg0.version
    }

    public(friend) fun increment_version(arg0: &mut Version) {
        arg0.version = arg0.version + 1;
    }

    public(friend) fun init_version() : Version {
        Version{version: 2}
    }

    // decompiled from Move bytecode v6
}

