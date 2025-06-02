module 0x1c56597633d9c54873372dd1a16749e14e09181c16a65f64c8a2cf1199663098::public_access {
    struct PublicAccess has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicAccess{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PublicAccess>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PublicAccess, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1c56597633d9c54873372dd1a16749e14e09181c16a65f64c8a2cf1199663098::utils::is_prefix(0x2::object::uid_to_bytes(&arg1.id), arg0), 0);
    }

    // decompiled from Move bytecode v6
}

