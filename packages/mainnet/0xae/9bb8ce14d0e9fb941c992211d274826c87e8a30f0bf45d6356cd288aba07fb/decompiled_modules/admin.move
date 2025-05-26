module 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

