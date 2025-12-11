module 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::merchant_actions {
    public entry fun activate_product_and_device(arg0: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::TelephoneProduct, arg1: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::Device, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::activate_product(arg0, arg4);
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::list_device_for_sale(arg1, arg2, 0x1::string::utf8(b"NGN"), 0x1::string::utf8(b"Lagos"), arg3, arg4);
    }

    public entry fun deactivate_product_and_device(arg0: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::TelephoneProduct, arg1: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::Device, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::deactivate_product(arg0, arg3);
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::unlist_device(arg1, arg2, arg3);
    }

    public entry fun list_product_with_device(arg0: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::DeviceRegistry, arg1: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::ProductRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: u64, arg16: u64, arg17: u64, arg18: 0x1::string::String, arg19: 0x1::string::String, arg20: u64, arg21: vector<0x1::string::String>, arg22: vector<0x1::string::String>, arg23: vector<0x1::string::String>, arg24: vector<0x1::string::String>, arg25: bool, arg26: 0x1::string::String, arg27: 0x1::string::String, arg28: u64, arg29: 0x1::string::String, arg30: 0x1::string::String, arg31: u64, arg32: 0x1::option::Option<0x2::object::ID>, arg33: &0x2::clock::Clock, arg34: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg26) > 0, 2);
        assert!(arg15 > 0, 1);
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::register_device(arg0, arg26, arg27, arg6, arg2, arg8, arg10, arg28, arg29, arg30, arg31, arg7, arg32, arg33, arg34);
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::list_telephone_product(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg33, arg34);
    }

    public entry fun update_product_price(arg0: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::TelephoneProduct, arg1: &mut 0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::Device, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::product_listing::update_product(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0xf16e3660d70391c4ec4d88b0ae4e868f4251e8e6933b45b83571b4d8318149c4::device_provenance::list_device_for_sale(arg1, arg2, 0x1::string::utf8(b"NGN"), 0x1::string::utf8(b"Lagos"), arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

