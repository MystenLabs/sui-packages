module 0xabd8ecb5ddfb40882c000b9f50745ec0f85572282e97bd986721dca030df3b45::cloax {
    struct CLOAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3sGUMLzbziYkNLQHq7mAB3HHLQJbupKGLYQpxmwDpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CLOAX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CLOAX       ")))), trim_right(b"CLOAX                           "), trim_right(x"434c4f41582069736e74206a757374206120636f696e697473206120707572706f73652d64726976656e206d656d65206d6f76656d656e742e200a0a5468697320697320666f7220746865206f6e65732077686f207175657374696f6e2065766572797468696e672c2077686f20736565207061747465726e7320696e207468652073746174696320616e64206c69657320696e2074686520686561646c696e65732e0a0a426f726e2066726f6d20746865206d656d6573207468657920646f6e742077616e7420796f7520746f207365652c20706f77657265642062792074686520747275746873207468657920747269656420746f20627572792c20616e642070726f74656374656420627920612062726f74686572686f6f64206f66206d696c6c696f6e732077686f206765742069742e200a0a546865206d69737369"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOAX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOAX>>(v4);
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

