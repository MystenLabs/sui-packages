module 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::versioning {
    struct Versioning has store {
        min_version: u64,
    }

    public(friend) fun assert_valid_version(arg0: &Versioning) {
        assert!(is_valid_version(arg0, 1), 13835058188426149889);
    }

    public(friend) fun is_valid_version(arg0: &Versioning, arg1: u64) : bool {
        arg1 >= arg0.min_version
    }

    public(friend) fun min_version(arg0: &Versioning) : u64 {
        arg0.min_version
    }

    public(friend) fun new() : Versioning {
        Versioning{min_version: 1}
    }

    public(friend) fun retire_older_versions(arg0: &mut Versioning) : bool {
        let v0 = 1;
        let v1 = v0 > arg0.min_version;
        if (v1) {
            arg0.min_version = v0;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

