module 0x4b331e6bc1afaf5ab61a61a57f19a610fbef03c1174bf0154ccf15893d80c049::version {
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

