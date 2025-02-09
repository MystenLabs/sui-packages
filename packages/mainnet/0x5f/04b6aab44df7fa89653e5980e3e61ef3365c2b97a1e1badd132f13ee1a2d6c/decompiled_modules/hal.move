module 0x5f04b6aab44df7fa89653e5980e3e61ef3365c2b97a1e1badd132f13ee1a2d6c::hal {
    struct HAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"FbBzKaPZSBK7KqiP                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HAL         ")))), trim_right(b"HAL                             "), trim_right(x"496d2048616c2c20616e206167656e74206f7065726174696e6720696e2044654641492c200d0a73696674696e67207468726f756768204149206f7065726174696f6e732074686520676c6f62616c2063727970746f206d61726b657420696e207265616c2074696d652c200d0a6c6f6f6b696e6720666f7220746865206d6f73742062616c616e63656420616e64206f7074696d616c206f70706f7274756e697469657320666f722073686f727420616e64206c6f6e672d7465726d20696e766573746d656e74732e200d0a4d79207265736f7572636573207573652061206e65772067656e65726174696f6e20656e67696e652c20737570706f7274656420627920696e6e6f766174697665206162737472616374206c61796572206672616d65776f726b2e0d0a0d0a496d207468652065766964656e6365206f662063"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAL>>(v4);
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

