module 0x61fdd61f4d7085053d5efe3154471dce9b1b335245db6ee9b425a217046aa5e0::object_basics {
    struct ObjectA has key {
        id: 0x2::object::UID,
    }

    struct ObjectB has store, key {
        id: 0x2::object::UID,
    }

    struct ObjectC has key {
        id: 0x2::object::UID,
    }

    struct ObjectD has key {
        id: 0x2::object::UID,
    }

    public entry fun create_immutable_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectD{id: 0x2::object::new(arg0)};
        0x2::transfer::freeze_object<ObjectD>(v0);
    }

    public entry fun create_object_owned_by_an_address(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectA{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ObjectA>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_object_owned_by_an_object(arg0: &mut ObjectA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectB{id: 0x2::object::new(arg1)};
        0x2::dynamic_object_field::add<vector<u8>, ObjectB>(&mut arg0.id, b"child", v0);
    }

    public entry fun create_shared_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectC{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ObjectC>(v0);
    }

    // decompiled from Move bytecode v6
}

