module 0x2dac4b3300be0ddbd393ac7d3f74c740063853688d95a630e7cfa17c9778b656::roots {
    struct ROOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"78da27f95186837631fbcae1cb57ca42360c9f85fa0938cd9bf263c5e349b2c5                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ROOTS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ROOTS       ")))), trim_right(b"Return to Beginnings            "), trim_right(x"466f7220746f6f206c6f6e67207765206861766520737472617965642066726f6d2074686520726f6f74732074686174206d616465200a4070756d70646f7466756e20736f2067726561742e0a0a57652068617665206c6f73742077686174206d616b657320626167776f726b696e672066756e2c20616e642063686173696e672061206e6172726174697665207765207472756c792062656c6965766520696e2e0a0a4c657473206d616b65206d656d65636f696e7320677265617420616761696e2e205468726f75676820636f6d6d756e6974792c20636f6e76696374696f6e2c20616e642061207066702063756c742e0a0a5468697320697320616c6c2061206c6f7374206172742e204974732074696d6520746f20676f206261636b20746f207468652024524f4f54532e2020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOTS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOTS>>(v4);
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

