module 0x80821ac14998be4faf0dfac481b0c1a3c2c1abd2b1b1dad9c65dc7e586c35c2b::version {
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

