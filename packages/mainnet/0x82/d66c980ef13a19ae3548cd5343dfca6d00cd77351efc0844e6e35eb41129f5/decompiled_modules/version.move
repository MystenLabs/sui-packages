module 0x43f97b8e1113263e19cc9f781af815917dfb55720a60f40817586ee3f87b1f6e::version {
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

