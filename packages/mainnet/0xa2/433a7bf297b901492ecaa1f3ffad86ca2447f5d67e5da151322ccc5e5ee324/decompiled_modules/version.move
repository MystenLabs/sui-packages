module 0x7437bc0b36d323631c266c9635ad8afde38dde64c82a52f65fc5e6cb01b0736::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun assert_correct_package(arg0: &Version) {
        assert!(arg0.version <= 1, 9223372410516930561);
    }

    public(friend) fun create_version<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372264488173571);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun current_version() : u64 {
        1
    }

    public fun upgrade_version(arg0: &0x7437bc0b36d323631c266c9635ad8afde38dde64c82a52f65fc5e6cb01b0736::authority::AuthorityCap<0x7437bc0b36d323631c266c9635ad8afde38dde64c82a52f65fc5e6cb01b0736::authority::PACKAGE<0x7437bc0b36d323631c266c9635ad8afde38dde64c82a52f65fc5e6cb01b0736::authority::ADMIN>>, arg1: &mut Version) {
        assert!(arg1.version == 1 - 1, 9223372350387388417);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

