module 0xd548971fd708f3764392f766692e9686ef5687c0927fe2f7a813609b91b34363::version {
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

