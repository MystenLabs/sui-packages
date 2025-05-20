module 0xd9664d300c233f953dd9775f531706a58c602225bff4df4a7a2cd8274e5f5c83::test_obj {
    struct TEST_OBJ has drop {
        dummy_field: bool,
    }

    struct OBJ has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
    }

    public fun new_obj(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x1::string::String) {
        let v0 = OBJ{
            id      : 0x2::object::new(arg0),
            content : arg1,
        };
        0x2::transfer::public_transfer<OBJ>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

