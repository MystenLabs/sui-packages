module 0x55105b370e0ef785dbac4f3ff959b2ec1421c18d4e48d630028acfa09824ae2a::nc {
    struct NC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/B89Hd5Juz7JP2dxCZXFJWk4tMTcbw7feDhuWGb3kq5qE.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NC          ")))), trim_right(b"Nodecoin                        "), trim_right(b"Nodepay is a decentralized platform that enables users to monetize their unused internet bandwidth by contributing to AI training and development. By installing the Nodepay browser extension and mobile app, users can earn rewards through activities such as bandwidth sharing, real-time data retrieval, reinforcement lear"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NC>>(v4);
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

