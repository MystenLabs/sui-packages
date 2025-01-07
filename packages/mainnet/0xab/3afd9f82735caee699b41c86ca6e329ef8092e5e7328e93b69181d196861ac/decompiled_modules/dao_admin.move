module 0xab3afd9f82735caee699b41c86ca6e329ef8092e5e7328e93b69181d196861ac::dao_admin {
    struct DaoOwner has store, key {
        id: 0x2::object::UID,
    }

    struct DaoAdmin has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DaoOwner{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<DaoOwner>(v0, arg0);
    }

    public entry fun burn(arg0: DaoAdmin) {
        let DaoAdmin { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun new_admin(arg0: &DaoOwner, arg1: &mut 0x2::tx_context::TxContext) : DaoAdmin {
        new_dao_admin(arg1)
    }

    public(friend) fun new_dao_admin(arg0: &mut 0x2::tx_context::TxContext) : DaoAdmin {
        DaoAdmin{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

