module 0x6c3e84c68f4c34a604c40ebf2619cb290fc521e891ac37bf91d56728c3892b4f::poc {
    struct PoCKey has store, key {
        id: 0x2::object::UID,
    }

    public entry fun mint_dummy_key(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoCKey{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PoCKey>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun seal_approve_access(arg0: vector<u8>, arg1: &PoCKey) {
    }

    // decompiled from Move bytecode v7
}

