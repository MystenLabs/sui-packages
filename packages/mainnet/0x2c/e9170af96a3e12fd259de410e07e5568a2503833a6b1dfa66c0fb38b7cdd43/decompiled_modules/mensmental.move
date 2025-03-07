module 0x2ce9170af96a3e12fd259de410e07e5568a2503833a6b1dfa66c0fb38b7cdd43::mensmental {
    struct MENSMENTAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENSMENTAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"OjOcXfq5hfsOnMXY                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MENSMENTAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MensMental  ")))), trim_right(b"Mens Mental Health              "), trim_right(x"54686973206973206120636f6d6d756e697479206275696c74206279204d656e20666f72204d656e210d0a0d0a4d656e2773206d656e74616c206865616c74682063616e206265207369676e69666963616e746c7920616666656374656420627920746865207374726573736573206173736f63696174656420776974682063727970746f63757272656e637920696e766573746d656e742e2054686520766f6c6174696c697479206f66207468652063727970746f206d61726b65742063616e206c65616420746f20616e786965747920616e642066696e616e6369616c2070726573737572652c20706172746963756c61726c7920666f72206d656e2077686f206d6179206665656c20736f63696574616c206578706563746174696f6e7320746f20737563636565642066696e616e6369616c6c792e20416464697469"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENSMENTAL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MENSMENTAL>>(v4);
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

