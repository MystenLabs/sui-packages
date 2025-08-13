module 0x61995487243007c74ceaa17828eafb4cd00e296dd8e49a1dfdeda139e7515721::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9mAnyxAq8JQieHT7Lc47PVQbTK7ZVaaog8LwAbFzBAGS.png?claimId=wkxZBKxZN0RkmQO9                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WATER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WATER       ")))), trim_right(b"TeamWater                       "), trim_right(b"As a community and along side #Teamwater, we are mobilizing Solana based Web3 to tackle one of humanitys biggest challenges  clean, accessible water.  We are a running this in partnership with @bagsapp by turning trading activity into direct, verifiable donations to the Team Water initiative led by Mr. Beast and Rob Ro"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v4);
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

