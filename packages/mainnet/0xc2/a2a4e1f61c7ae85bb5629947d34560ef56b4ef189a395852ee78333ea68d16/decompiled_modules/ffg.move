module 0xc2a2a4e1f61c7ae85bb5629947d34560ef56b4ef189a395852ee78333ea68d16::ffg {
    struct FFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8aa01168276d5d7a9c8b4b67c581ecfeba69aa7d0ff554789b31bbbcaa3f5db5                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FFG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FFG         ")))), trim_right(b"FOOD FOR GAZA                   "), trim_right(x"464f4f4420464f522047415a410a0a54696b546f6b657220776974682031204d20666f6c6c6f77657273206973206e6f77206f6e2050756d702046756e2c2073747265616d696e67206461696c7920616e64207573696e6720323025206f662063726561746f72207265776172647320746f7761726473204d61726b6574696e6720616e642038302520746f776172647320627579696e6720666f6f647374756666206f6e206461696c7920626173697320746f20636f6f6b207468656d20696e20746865206e657874206d6f726e696e6720696e2047415a41206f6e206c6976652073747265616d202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFG>>(v4);
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

