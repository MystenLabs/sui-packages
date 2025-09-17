module 0xcfe30f0f609a1dc87ec6c00390630046590a446f8bb81d4e42968c582e75b1f2::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3ca49c0ca5fbb4eb9b92efdb3fcac0d608b62c8a1e5f6846bc50a28a5ab85ad3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WAIFU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WAIFU       ")))), trim_right(b"WAIFU COIN                      "), trim_right(b"WaifuCoin ($WAIFU) is a community-driven token merging anime culture with the power of Solana DeFi. Built for collectors, gamers, and crypto enthusiasts, WaifuCoin delivers unique utilities such as NFT integrations, staking rewards, and themed experiences. More than a token, its a movement  bringing creativity, culture"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIFU>>(v4);
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

