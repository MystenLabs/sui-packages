module 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority {
    struct CrimesCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CrimesCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CrimesCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

