module 0x5135e95b87108bb2a6241abf24b5caf4f8ec71ae08c73cc83b7d58ad9efe4b98::bonkpunks {
    struct BONKPUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CgCiQogzyyQLHACdzppSYfNEWAFmN3w3rJPvr9Bbonk.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BONKPUNKS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Bonkpunks   ")))), trim_right(b"Bonk Punks NFT                  "), trim_right(b"I am leading the Derug of Bonk Punk NFT which was  inspired by the best part of the Solana blockchain, $BONK. There are 962 Bonk Punks for grabs. Any revenue generated will be use to buy off the Bonk punk which will dramatically increase the price of the NFT as well as token price                                       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKPUNKS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKPUNKS>>(v4);
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

