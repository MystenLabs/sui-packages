module 0x688bc8ddbf5f1ddd188186590d597300139ff377e1f63275efedd9bea6bd3a6b::version {
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

