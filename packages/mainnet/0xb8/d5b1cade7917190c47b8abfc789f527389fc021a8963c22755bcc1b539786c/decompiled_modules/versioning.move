module 0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning {
    struct Versioning has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
    }

    public fun allowed_versions(arg0: &Versioning) : vector<u64> {
        *0x2::vec_set::keys<u64>(&arg0.allowed_versions)
    }

    public(friend) fun assert_version_allowed(arg0: &Versioning) {
        assert!(is_version_allowed(arg0), 0);
    }

    public(friend) fun disable(arg0: &mut Versioning, arg1: u64) {
        assert!(arg1 != 1, 1);
        assert!(is_version_allowed(arg0), 0);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg1);
    }

    public(friend) fun enable(arg0: &mut Versioning, arg1: u64) {
        assert!(0x2::vec_set::length<u64>(&arg0.allowed_versions) < 4, 2);
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg1);
    }

    public(friend) fun is_version_allowed(arg0: &Versioning) : bool {
        let v0 = 1;
        0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0)
    }

    public(friend) fun new() : Versioning {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 1);
        Versioning{allowed_versions: 0x2::vec_set::from_keys<u64>(v0)}
    }

    // decompiled from Move bytecode v7
}

