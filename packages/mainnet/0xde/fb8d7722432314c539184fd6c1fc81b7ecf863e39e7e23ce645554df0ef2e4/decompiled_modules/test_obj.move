module 0xdefb8d7722432314c539184fd6c1fc81b7ecf863e39e7e23ce645554df0ef2e4::test_obj {
    struct TEST_OBJ has drop {
        dummy_field: bool,
    }

    struct OBJ has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
    }

    public fun new_obj(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OBJ{
            id      : 0x2::object::new(arg1),
            content : arg0,
        };
        0x2::transfer::public_transfer<OBJ>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

