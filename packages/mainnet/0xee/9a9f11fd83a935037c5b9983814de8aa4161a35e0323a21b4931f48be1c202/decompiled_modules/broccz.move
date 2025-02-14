module 0xee9a9f11fd83a935037c5b9983814de8aa4161a35e0323a21b4931f48be1c202::broccz {
    struct BROCCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6VqXUhjgNpccwwu39267VWuCspZkdLiYTLHVRS3ppump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BROCCZ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BROCCZ      ")))), trim_right(b"OFFICIAL CZ DOG BROCCOLI        "), trim_right(x"4c65742055732050726f766520466f7220596f750a546861742057652041726520546865204265737420546f6b656e20466f7220657665722e2e0a0a41207265616c2073746f7279206f6620746865204d6f73742066616d6f757320446f6720496e2063727970746f0a0a547275737420546861742057652057696c6c20526561636820312042696c6c696f6e204d41524b455420434150202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCZ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROCCZ>>(v4);
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

