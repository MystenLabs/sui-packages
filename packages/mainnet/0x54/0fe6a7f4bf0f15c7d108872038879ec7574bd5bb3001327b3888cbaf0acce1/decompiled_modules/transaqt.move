module 0x540fe6a7f4bf0f15c7d108872038879ec7574bd5bb3001327b3888cbaf0acce1::transaqt {
    struct TRANSAQT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRANSAQT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"881b1914b57aa04d8322ee581b19b5c6f9b0cd214f8ff40aae73d59a9debca7b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRANSAQT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Transaqt    ")))), trim_right(b"TransaqtAI                      "), trim_right(b"TRANSAQT delivers cutting-edge AI infrastructure, premium datasets, and enterprise tools to help research teams accelerate model developmentand enables organizations to transform those models into scalable, production-ready intelligent systems.                                                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRANSAQT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRANSAQT>>(v4);
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

