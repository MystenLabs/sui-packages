module 0x9a4773e97b69623abd9f317ebf6f4ee9ce161b5defd93a41cf7bc2f24a7ff050::alibabaai {
    struct ALIBABAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIBABAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6tq8614cfS1QoRDxgzScvhcVGCEwkFAFzUcmjuybiAwh.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ALIBABAAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AlibabaAI   ")))), trim_right(b"Alibaba AI Agent                "), trim_right(b"The Alibaba AI Agent project is an innovative initiative that extends the iconic Alibaba brand logo. This project leverages the visual identity of Alibaba to create a unique and recognizable AI-driven agent. The logo, which is a key element of Alibaba's brand image, serves as the foundation for the design and functiona"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIBABAAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIBABAAI>>(v4);
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

