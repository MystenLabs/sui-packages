module 0x8b2c8a5e80dbf0cbdc5e4e730f736c68fb19a0df6dccb403149822d877a5073a::shoggoth {
    struct SHOGGOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOGGOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BoPBba5DBnuttdVoePJwuhcP3TjXhhLhSD6fD6Rdpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHOGGOTH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Shoggoth    ")))), trim_right(b"Shoggoth Mini                   "), trim_right(x"52656c656173696e672053686f67676f7468204d696e6921200a536f66742074656e7461636c6520726f626f74206d65657473204750542d346f202620524c2e200a49206275696c7420697420746f206578706c6f72652074686520626f756e646172696573206f662077656972643a20657870726573736976656e6573732c20616c6976656e6573732c20616e6420414920656d626f64696d656e742e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOGGOTH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOGGOTH>>(v4);
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

