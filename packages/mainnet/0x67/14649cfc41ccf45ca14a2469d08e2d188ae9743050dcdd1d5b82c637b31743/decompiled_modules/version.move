module 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::version {
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

