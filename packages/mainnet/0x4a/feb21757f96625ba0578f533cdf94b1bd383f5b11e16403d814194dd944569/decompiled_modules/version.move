module 0x4afeb21757f96625ba0578f533cdf94b1bd383f5b11e16403d814194dd944569::version {
    struct Version has drop, store {
        pos0: u16,
    }

    public(friend) fun assert_version(arg0: &Version, arg1: u16) {
        assert!(arg0.pos0 == arg1, 0);
    }

    public(friend) fun assert_version_and_upgrade(arg0: &mut Version, arg1: u16) {
        if (arg0.pos0 < arg1) {
            arg0.pos0 = arg1;
        };
        assert_version(arg0, arg1);
    }

    public(friend) fun migrate_(arg0: &mut Version, arg1: u16) {
        assert!(arg0.pos0 < arg1, 0);
        arg0.pos0 = arg1;
    }

    public(friend) fun new(arg0: u16) : Version {
        Version{pos0: arg0}
    }

    // decompiled from Move bytecode v6
}

