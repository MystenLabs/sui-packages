module 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::dao_admin {
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

