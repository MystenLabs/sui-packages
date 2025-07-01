module 0x7f44717f7dccf31070f2f84f290a01ab5943b175df97515244fa9da7f15f57b0::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_active_version(arg0: &Version) {
        assert!(is_active_version(arg0), 0);
    }

    public fun get_active_version(arg0: &Version) : u64 {
        arg0.value
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg1),
            value : 0x7f44717f7dccf31070f2f84f290a01ab5943b175df97515244fa9da7f15f57b0::current_version::value(),
        };
        0x2::transfer::share_object<Version>(v0);
        let v1 = VersionCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VersionCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_active_version(arg0: &Version) : bool {
        arg0.value == 0x7f44717f7dccf31070f2f84f290a01ab5943b175df97515244fa9da7f15f57b0::current_version::value()
    }

    public fun set_active_version(arg0: &VersionCap, arg1: &mut Version, arg2: u64) {
        arg1.value = arg2;
    }

    // decompiled from Move bytecode v6
}

