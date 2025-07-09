module 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority {
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

