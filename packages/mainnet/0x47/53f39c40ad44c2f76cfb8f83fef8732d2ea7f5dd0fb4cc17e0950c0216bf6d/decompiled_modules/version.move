module 0x4753f39c40ad44c2f76cfb8f83fef8732d2ea7f5dd0fb4cc17e0950c0216bf6d::version {
    struct Version has store {
        version: u16,
    }

    public(friend) fun check_version(arg0: &Version) {
        assert!(arg0.version == 0, 0);
    }

    public(friend) fun get_version(arg0: &Version) : u16 {
        arg0.version
    }

    public(friend) fun init_version() : Version {
        Version{version: 0}
    }

    // decompiled from Move bytecode v6
}

