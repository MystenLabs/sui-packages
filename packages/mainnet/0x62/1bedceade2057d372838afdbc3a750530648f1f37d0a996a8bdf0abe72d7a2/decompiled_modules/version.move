module 0x621bedceade2057d372838afdbc3a750530648f1f37d0a996a8bdf0abe72d7a2::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0x621bedceade2057d372838afdbc3a750530648f1f37d0a996a8bdf0abe72d7a2::error::version_mismatch_error());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x621bedceade2057d372838afdbc3a750530648f1f37d0a996a8bdf0abe72d7a2::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x621bedceade2057d372838afdbc3a750530648f1f37d0a996a8bdf0abe72d7a2::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0x621bedceade2057d372838afdbc3a750530648f1f37d0a996a8bdf0abe72d7a2::current_version::current_version() + 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

