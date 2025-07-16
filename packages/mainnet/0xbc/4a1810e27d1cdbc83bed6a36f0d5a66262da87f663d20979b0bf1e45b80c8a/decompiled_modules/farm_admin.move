module 0xbc4a1810e27d1cdbc83bed6a36f0d5a66262da87f663d20979b0bf1e45b80c8a::farm_admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
    }

    public(friend) fun get_farm_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.farm_id
    }

    public(friend) fun intern_new_farm_admin(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id      : 0x2::object::new(arg1),
            farm_id : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

