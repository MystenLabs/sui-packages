module 0x10e2f190f71a6c56991673cce673d8bafdfc5c850d6507f94d7c6d58dfd65963::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0x10e2f190f71a6c56991673cce673d8bafdfc5c850d6507f94d7c6d58dfd65963::error::version_mismatch_error());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x10e2f190f71a6c56991673cce673d8bafdfc5c850d6507f94d7c6d58dfd65963::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x10e2f190f71a6c56991673cce673d8bafdfc5c850d6507f94d7c6d58dfd65963::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0x10e2f190f71a6c56991673cce673d8bafdfc5c850d6507f94d7c6d58dfd65963::current_version::current_version() + 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

