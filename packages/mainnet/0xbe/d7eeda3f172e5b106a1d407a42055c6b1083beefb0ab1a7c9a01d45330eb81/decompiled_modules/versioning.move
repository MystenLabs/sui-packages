module 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::versioning {
    struct Versioning has copy, drop, store {
        blocked_versions: 0x2::vec_set::VecSet<u64>,
    }

    public fun assert_is_valid_version(arg0: &Versioning) {
        assert!(is_valid_version(arg0, 1), 13835058218490920961);
    }

    public(friend) fun block_version(arg0: &mut Versioning, arg1: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.blocked_versions, arg1);
    }

    public fun is_valid_version(arg0: &Versioning, arg1: u64) : bool {
        !0x2::vec_set::contains<u64>(&arg0.blocked_versions, &arg1)
    }

    public(friend) fun new() : Versioning {
        Versioning{blocked_versions: 0x2::vec_set::empty<u64>()}
    }

    public(friend) fun unblock_version(arg0: &mut Versioning, arg1: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.blocked_versions, &arg1);
    }

    // decompiled from Move bytecode v7
}

