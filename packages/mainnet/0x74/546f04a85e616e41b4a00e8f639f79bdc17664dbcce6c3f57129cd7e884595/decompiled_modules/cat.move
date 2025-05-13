module 0x74546f04a85e616e41b4a00e8f639f79bdc17664dbcce6c3f57129cd7e884595::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x21bf4ac079cd571727df85b32758bf7a35b5a4f39463c6b8ffec4560ce6c17c8::connector_v3::new<CAT>(arg0, 1000, b"s_sui", b"n_sui", b"d_sui", b"u_sui", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

