module 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun assert_correct_package(arg0: &Version) {
        assert!(arg0.version == 1, 9223372384747126785);
    }

    public(friend) fun create_version<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372260193206275);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun current_version() : u64 {
        1
    }

    public fun upgrade_version(arg0: &0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::admin::AdminCap, arg1: &mut Version) {
        assert!(arg1.version == 1 - 1, 9223372346092421121);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

