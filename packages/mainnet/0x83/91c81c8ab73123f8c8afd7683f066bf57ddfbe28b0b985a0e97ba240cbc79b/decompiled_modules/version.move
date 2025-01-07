module 0x80cf6e11b49a7667dd929609bcc76e4a79273bfc91257328dd0320d2e3bd1a2e::version {
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

