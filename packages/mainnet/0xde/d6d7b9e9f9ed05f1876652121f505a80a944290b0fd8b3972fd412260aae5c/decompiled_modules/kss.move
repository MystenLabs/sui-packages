module 0xded6d7b9e9f9ed05f1876652121f505a80a944290b0fd8b3972fd412260aae5c::kss {
    struct KSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d50997e151a84639a2fc23ccbb13b9b79c56c67fc253bc507b9aec3e410f664a                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KSS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"kss         ")))), trim_right(b"kissiicoin                      "), trim_right(b"Kissiicoin is all about love, laughs, and wins! Built for the culture and powered by community vibes, this token turns good energy into real growth. Streaming on pump fun, were here to kiss off the old boring coins and bring something fresh, fun, and unforgettable.                                                       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSS>>(v4);
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

