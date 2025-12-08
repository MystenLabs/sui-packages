module 0x5c0fa5dc36dff27a448d52a03d39c062f124d83fb897adf199dd7dd33d9c07c8::thrt {
    struct THRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THRT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"31455c140b5d387c565d5be5eb23eb9e54907d4b7a69decd9547be5f285aad41                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THRT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"THRT        ")))), trim_right(b"Threat Research & History Trail "), trim_right(x"54485254206973206120626c6f636b636861696e2d706f776572656420706c6174666f726d2077686f736520676f616c20697320746f20646563656e7472616c697a652066696c6520636c617373696669636174696f6e20666f720a736166652c206d616c6963696f75732c206f7220756e6b6e6f776e2220726573756c747320616e6420656e637279707465642041492f4d4c20747261696e696e672064617461736574732e204275696c74206f6e0a74686520536f6c616e6120626c6f636b636861696e2c2054485254206c6576657261676573207075626c6963207472616e73706172656e63792c206461746120696d6d75746162696c6974792c20616e6420746f6b656e2d0a676174656420616363657373206c656164696e6720746f2074686520656d706f7765726d656e74206f662073747564656e74732c2072"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THRT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THRT>>(v4);
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

