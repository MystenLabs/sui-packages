module 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::chest {
    struct SamChest has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun burn(arg0: SamChest) {
        let SamChest { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun mint(arg0: &mut 0x2::tx_context::TxContext) : SamChest {
        SamChest{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

