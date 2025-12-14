module 0xa584b16e6ea0b648954efdbb82593d023466b18413268c7bf04a6d6b5827c4fd::gboy {
    struct GBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6c2c8e481ef728624948247d704e50a8ea0f96c556d86e84471210847064d8fa                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GBOY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GBOY        ")))), trim_right(b"G*BOY                           "), trim_right(x"41626f7574204e45554b4f0a0a4e45554b4f20697320612070696f6e656572696e6720414920706c6174666f726d207472616e73666f726d696e67206469676974616c2063726561746976697479207468726f75676820616476616e6365642070726f6d70742d626173656420746f6f6c7320666f722067656e65726174696e6720696d6d65727369766520776f726c64732c20636861726163746572732c20616e64206d656d65732c20666f73746572696e6720636f6d6d756e6974792d64726976656e2073746f727974656c6c696e6720696e206120637962657270756e6b2d696e73706972656420756e6976657273652e0a0a5765277265206275696c64696e67207468652063726561746f72206f7065726174696e672073797374656d20666f722041492d6e61746976652049502062792066697273742070726f76"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBOY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBOY>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

