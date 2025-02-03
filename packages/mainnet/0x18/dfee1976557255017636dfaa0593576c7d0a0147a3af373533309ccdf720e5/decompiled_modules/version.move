module 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::error::version_mismatch_error());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::current_version::current_version() + 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

