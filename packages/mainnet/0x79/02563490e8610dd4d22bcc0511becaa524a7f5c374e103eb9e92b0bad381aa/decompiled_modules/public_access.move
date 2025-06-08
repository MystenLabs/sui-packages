module 0x7902563490e8610dd4d22bcc0511becaa524a7f5c374e103eb9e92b0bad381aa::public_access {
    struct PublicAccess has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicAccess{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PublicAccess>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &PublicAccess, arg2: &0x2::tx_context::TxContext) {
        assert!(0x7902563490e8610dd4d22bcc0511becaa524a7f5c374e103eb9e92b0bad381aa::utils::is_prefix(0x2::object::uid_to_bytes(&arg1.id), arg0), 0);
    }

    // decompiled from Move bytecode v6
}

