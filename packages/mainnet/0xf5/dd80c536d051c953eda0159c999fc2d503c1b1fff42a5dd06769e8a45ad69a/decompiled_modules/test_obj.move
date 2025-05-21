module 0x49612733785585b51e00cf8d5c6dace13ad8bbdef920ae9b6325f4d48dd505f6::test_obj {
    struct TEST_OBJ has drop {
        dummy_field: bool,
    }

    struct OBJ has store, key {
        id: 0x2::object::UID,
        content: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    public fun init_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_obj(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg2);
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg0, v0), *0x1::vector::borrow<0x1::string::String>(&arg1, v0));
            v0 = v0 + 1;
        };
        let v2 = OBJ{
            id      : 0x2::object::new(arg2),
            content : v1,
        };
        0x2::transfer::public_transfer<OBJ>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

