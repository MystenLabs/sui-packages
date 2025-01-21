module 0x7f65e6374d520ec5d7613a890b1399b64a960cd6ed0b8531078f9fcce864f5e8::sqd {
    struct SQD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Uz6NUPXYfNtEr68vSW4uMEQZe6bk6BXANoJdvd9Ly5S.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SQD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SQD     ")))), trim_right(b"Squid                           "), trim_right(x"22537175696420436f696e2069732061206d656d6520746f6b656e20696e73706972656420627920612066616d6f75732070696e6b2073717569642c20626c656e64696e672068756d6f72207769746820612073706c617368206f66206372656174697669747920696e207468652063727970746f2073706163652e204469766520696e746f207468652066756e20616e64206a6f696e206120636f6d6d756e6974792074686174732061732076696272616e7420616e6420626f6c642061732074686520737175696420697473656c6621220a0a436865636b206f7574205820616e64206f757220776562736974652120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQD>>(v4);
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

