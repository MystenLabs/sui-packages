module 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::error::version_mismatch_error());
    }

    public fun block(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::current_version::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::current_version::current_version()
    }

    public fun update(arg0: &mut Version, arg1: &VersionCap) {
        assert!(arg0.value < 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::current_version::current_version(), 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::error::version_mismatch_error());
        arg0.value = 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

