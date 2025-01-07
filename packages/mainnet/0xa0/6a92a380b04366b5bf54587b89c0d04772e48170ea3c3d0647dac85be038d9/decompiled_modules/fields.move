module 0xa06a92a380b04366b5bf54587b89c0d04772e48170ea3c3d0647dac85be038d9::fields {
    struct FieldsDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Fields has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun fields(arg0: &0x2::object::UID) : &0x2::object::UID {
        let v0 = FieldsDfKey{dummy_field: false};
        &0x2::dynamic_field::borrow<FieldsDfKey, Fields>(arg0, v0).id
    }

    public(friend) fun fields_mut(arg0: &mut 0x2::object::UID) : &mut 0x2::object::UID {
        let v0 = FieldsDfKey{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<FieldsDfKey, Fields>(arg0, v0).id
    }

    public(friend) fun init_fields(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FieldsDfKey{dummy_field: false};
        let v1 = Fields{id: 0x2::object::new(arg1)};
        0x2::dynamic_field::add<FieldsDfKey, Fields>(arg0, v0, v1);
    }

    public(friend) fun insert_fields(arg0: &mut 0x2::object::UID, arg1: Fields) {
        let v0 = FieldsDfKey{dummy_field: false};
        0x2::dynamic_field::add<FieldsDfKey, Fields>(arg0, v0, arg1);
    }

    public(friend) fun pop_fields(arg0: &mut 0x2::object::UID) : Fields {
        let v0 = FieldsDfKey{dummy_field: false};
        0x2::dynamic_field::remove<FieldsDfKey, Fields>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

