module 0x1ad7fed97c5a500847bd74e8dbc1a35f5403ec96e479c7362e8d1d5b6f20f707::utils {
    struct S has drop {
        dummy_field: bool,
    }

    struct T<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Test has copy, drop {
        val: 0x1::string::String,
    }

    public fun byte_to_hex(arg0: u8) : 0x1::string::String {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(*0x1::vector::borrow<u8>(&v0, ((arg0 >> 4 & 15) as u64)))));
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(*0x1::vector::borrow<u8>(&v0, ((arg0 & 15) as u64)))));
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = T<S>{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<T<S>>(v0);
    }

    public entry fun test_get_py_name<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = Test{val: 0x1::string::from_ascii(0x1::type_name::get_module(&v0))};
        0x2::event::emit<Test>(v1);
    }

    public fun vector_to_hex_string(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::string::append(&mut v0, byte_to_hex(*0x1::vector::borrow<u8>(&arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

