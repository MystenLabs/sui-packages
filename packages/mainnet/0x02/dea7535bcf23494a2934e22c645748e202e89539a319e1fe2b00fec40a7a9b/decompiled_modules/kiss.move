module 0x2dea7535bcf23494a2934e22c645748e202e89539a319e1fe2b00fec40a7a9b::kiss {
    struct KISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"zwejwEZPlJuv6oIj                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KISS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KISS        ")))), trim_right(b"KISS                            "), trim_right(x"20244b495353202054686520436f696e204d6164652066726f6d204c6f766521200d0a0d0a5468652042494747455354206c6f7665206d656d65636f696e206861732061727269766564212020244b495353206973206d6f7265207468616e206a757374206120746f6b656e697473206120676c6f62616c206d6f76656d656e74206675656c6564206279206c6f76652c20636f6e6e656374696f6e2c20616e6420636f6d6d756e6974792e0d0a0d0a205374726f6e6720262050617373696f6e61746520436f6d6d756e6974790d0a204c6f76652d506f776572656420262052656c617461626c6520746f2045766572796f6e650d0a204d6f6f6e20506f74656e7469616c2020446f6e74204d697373204f7574210d0a0d0a204c6f76652062656c6f6e677320696e20796f75722077616c6c65742e2047657420796f7572"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISS>>(v4);
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

