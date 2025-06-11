module 0xa82c8ec4ad67b58a1e3b6ec7158781a7c87e714b74d04d4ec7ce4fccf30e255a::btromp {
    struct BTROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTROMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AhMyrvkpMPzYhv6XvkSa8yvBwkxZfF7aUtmvY8tipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTROMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTROMP      ")))), trim_right(b"BOOK OF TROMP                   "), trim_right(b"Book of Tromp  ($BTROMP) - A legendary meme coin on the Solana blockchain, reborn through the unwavering passion of it's community. $BTROMP, led by Pepe's infamous uncle, Donald J. Tromp (with an \"O\"), stands as the self-proclaimed President and Commander In Chief of All Meme Coins, with a bold mission to MAKE MEME COI"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTROMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTROMP>>(v4);
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

