module 0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_version(arg0: &Version) {
        assert!(arg0.value == 1, 0);
    }

    public fun freeze_version(arg0: &AdminCap, arg1: &mut Version) {
        arg1.value = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 1,
        };
        0x2::transfer::share_object<Version>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Version) {
        assert!(arg1.value < 1, 0);
        arg1.value = 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

