module 0xdb674006027402dda2a8a7fa1069c0f12c55290d361f2449769730a7a1fd89b6::version {
    struct Version has store {
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

