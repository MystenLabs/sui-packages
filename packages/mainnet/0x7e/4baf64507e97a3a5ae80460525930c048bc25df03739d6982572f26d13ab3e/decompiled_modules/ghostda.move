module 0x7e4baf64507e97a3a5ae80460525930c048bc25df03739d6982572f26d13ab3e::ghostda {
    struct GHOSTDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOSTDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e8d316d5a3cf799943467bee66bf391342c0f01a0d63aa3c774aeba2cbe2fcaa                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GHOSTDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Ghostd      ")))), trim_right(b"Ghosted                         "), trim_right(x"47484f53544544206973206d6f7265207468616e2061206469676974616c2061737365743b2069747320612073616e63747561727920666f722074686520726573696c69656e742e205765206172652074686520636f6d6d756e697479206f6620746865206f7665726c6f6f6b65642c20746865206d6973756e64657273746f6f642c20616e64207468652062657472617965642c2077686f206861766520616c6c206d6164652061207361637265642061677265656d656e743a204e6f206f6e6520676574732047686f7374656420686572652e0a0a5768656e20796f75206275792047484f535445442c20796f752061726520646f696e67206d6f7265207468616e207365637572696e67206120746f6b656e3b20796f7520617265206d616b696e67206120626f6c642073746174656d656e743a0a0a596f752072656a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOSTDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOSTDA>>(v4);
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

