module 0x9b7409d4ff148b6f728edfc7beeb424e904d7dbde7054602c7ac98d3d87feecc::archieve {
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
        let v0 = UserReg{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_share_object<UserReg>(v0);
    }

    public entry fun register(arg0: &mut UserReg, arg1: &mut 0x2::tx_context::TxContext) {
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

