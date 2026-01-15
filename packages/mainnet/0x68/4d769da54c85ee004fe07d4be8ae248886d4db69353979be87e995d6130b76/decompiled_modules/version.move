module 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version {
    struct VersionAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check(arg0: &Version) {
        assert!(arg0.version == 1, 0);
    }

    public fun current() : u64 {
        1
    }

    public fun get(arg0: &Version) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VersionAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v1);
    }

    public fun migrate(arg0: &VersionAdminCap, arg1: &mut Version) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

