module 0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: &Version) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun init_package_version<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    // decompiled from Move bytecode v6
}

