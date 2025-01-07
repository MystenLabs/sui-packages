module 0x666265cffcb50366f4584365dd5b37fd912b2f2337d8eab723818e65623103b::gacha {
    struct GACHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GACHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9Z3LF3ymEVwCPLd9uBda9ieySYKVK7MzukPRGHDPpump.png?size=lg&key=fe7d3b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GACHA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Gacha   ")))), trim_right(b"Gacha                           "), trim_right(b"Genshin Impact is a 2020 action role-playing video game produced by MiHoYo/HoYovers, it is also the most famous game in China. Life is a Gacha. $Gacha travelers, it's time to start co-op mode and build the Genshin Family!                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GACHA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GACHA>>(v4);
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

