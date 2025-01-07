module 0x18835736313157a2d53a25102d23687ebbc5725a42bda01f6e99082770b2f65d::dao_admin {
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

