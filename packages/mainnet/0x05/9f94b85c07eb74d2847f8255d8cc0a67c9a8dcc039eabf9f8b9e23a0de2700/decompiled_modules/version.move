module 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::version {
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

