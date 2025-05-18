module 0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::chest {
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

