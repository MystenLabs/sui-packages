module 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::version {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun assert_correct_package(arg0: &Version) {
        assert!(arg0.version <= 1, 13906834548005535745);
    }

    public(friend) fun create_version<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13906834401976778755);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun current_version() : u64 {
        1
    }

    public fun upgrade_version(arg0: &0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::authority::AuthorityCap<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::authority::PACKAGE<0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::authority::ADMIN>>, arg1: &mut Version) {
        assert!(arg1.version == 1 - 1, 13906834487875993601);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

