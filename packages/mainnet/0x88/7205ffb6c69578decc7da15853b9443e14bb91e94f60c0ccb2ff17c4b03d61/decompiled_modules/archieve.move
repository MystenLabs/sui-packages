module 0x887205ffb6c69578decc7da15853b9443e14bb91e94f60c0ccb2ff17c4b03d61::archieve {
    struct ARCHIEVE has drop {
        dummy_field: bool,
    }

    struct UserArchieve has store, key {
        id: 0x2::object::UID,
    }

    struct UserReg has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, bool>,
    }

    fun init(arg0: ARCHIEVE, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun register(arg0: &mut UserReg, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 8003);
        let v1 = UserArchieve{id: 0x2::object::new(arg1)};
        0x2::table::add<address, bool>(&mut arg0.users, v0, true);
        0x2::transfer::public_transfer<UserArchieve>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun verify(arg0: &mut UserArchieve) {
    }

    // decompiled from Move bytecode v6
}

