module 0x6af037bb10c1e1aada501a20eff086d206e004c89bc0cacddaea96dae708d768::farm_admin {
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

