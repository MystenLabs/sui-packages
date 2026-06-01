module 0x15fbc01e79687beea3c06e1a93ece74786963c4c399d4e52508fd802306855b2::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun assert_correct_package(arg0: &Version) {
        assert!(arg0.version <= 1, 13906834530825666561);
    }

    public(friend) fun create_version<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13906834384796909571);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun current_version() : u64 {
        1
    }

    public fun upgrade_version(arg0: &0x15fbc01e79687beea3c06e1a93ece74786963c4c399d4e52508fd802306855b2::admin::AdminCap, arg1: &mut Version) {
        assert!(arg1.version == 1 - 1, 13906834470696124417);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v7
}

