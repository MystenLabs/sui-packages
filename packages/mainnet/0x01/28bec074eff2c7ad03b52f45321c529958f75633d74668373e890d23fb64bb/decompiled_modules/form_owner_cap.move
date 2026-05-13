module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap {
    struct FormOwnerCap has store, key {
        id: 0x2::object::UID,
        form_id: address,
    }

    public(friend) fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : FormOwnerCap {
        FormOwnerCap{
            id      : 0x2::object::new(arg1),
            form_id : arg0,
        }
    }

    public(friend) fun assert_for(arg0: &FormOwnerCap, arg1: address) {
        assert!(arg0.form_id == arg1, 0);
    }

    public fun form_id(arg0: &FormOwnerCap) : address {
        arg0.form_id
    }

    public fun id(arg0: &FormOwnerCap) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v6
}

