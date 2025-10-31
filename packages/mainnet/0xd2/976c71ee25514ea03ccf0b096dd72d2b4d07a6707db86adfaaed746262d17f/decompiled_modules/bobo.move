module 0xd2976c71ee25514ea03ccf0b096dd72d2b4d07a6707db86adfaaed746262d17f::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6a51ad93ddf8d72976fcaae9b8af3388f96b2f4f613253b1480b831dc16fc076                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOBO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOBO        ")))), trim_right(b"Bobo The Frog                   "), trim_right(x"496e207468652077696c6465726e657373206f662074686520536f6c616e6120626c6f636b636861696e2c206576657279206a6f75726e6579206e65656473206120666561726c6573732067756964652e204d6565742024424f424f207468652066726f672076656e747572696e6720696e746f20756e63686172746564207465727269746f727920616e64206372656174696e67206e657720747261696c7320666f72206f746865727320746f20666f6c6c6f772e0a0a41726d6564207769746820637572696f736974792c20636f75726167652c20616e6420616e20756e7368616b61626c652062656c69656620696e2074686520706f776572206f6620636f6d6d756e6974792e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v4);
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

