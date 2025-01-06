module 0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::version {
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

    public fun upgrade_version(arg0: &0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin::AdminCap, arg1: &mut Version) {
        assert!(arg1.version == 1 - 1, 9223372346092421121);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

