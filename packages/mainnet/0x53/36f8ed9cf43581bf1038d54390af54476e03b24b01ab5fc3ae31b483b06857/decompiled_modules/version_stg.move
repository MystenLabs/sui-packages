module 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::version_stg {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 69);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::current_version_stg::current_version(),
        };
        let v1 = VersionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Version>(v0);
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::current_version_stg::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &VersionCap) {
        arg0.value = 0x5336f8ed9cf43581bf1038d54390af54476e03b24b01ab5fc3ae31b483b06857::current_version_stg::current_version() + 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

