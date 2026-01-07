module 0x9a12d642c9bde0e39176948f1447b36469011c473a5edfb101109c20596e2597::version {
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

    public(friend) fun new(arg0: u16) : Version {
        Version{pos0: arg0}
    }

    // decompiled from Move bytecode v6
}

