module 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::chest {
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

