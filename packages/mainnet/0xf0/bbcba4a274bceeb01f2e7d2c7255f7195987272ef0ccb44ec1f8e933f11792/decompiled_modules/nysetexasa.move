module 0xf0bbcba4a274bceeb01f2e7d2c7255f7195987272ef0ccb44ec1f8e933f11792::nysetexasa {
    struct NYSETEXASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYSETEXASA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"xYai67vXsipFRa8a                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NYSETEXASA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NYSETexas   ")))), trim_right(b"TXSE                            "), trim_right(b"TXSE is the official token of NYSE Texas, a bold and visionary project set to redefine how financial markets operate in the Web3 era. Inspired by the independence, grit, and entrepreneurial legacy of the Lone Star State, NYSE Texas blends Texan spirit with blockchain innovation to create a decentralized alternative to "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYSETEXASA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYSETEXASA>>(v4);
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

