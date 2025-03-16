module 0xb2f862a56d624102e9cb7399a8db64ca62141e7d5bfa666a4fc5d17d549e72e2::inv {
    struct INV has drop {
        dummy_field: bool,
    }

    fun init(arg0: INV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/35HdnBrPMAWkETszMaYqVSKzA3fZU1TRZxZKri6MMgn9.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<INV>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"INV         ")))), trim_right(b"Invincible                      "), trim_right(b"InvincibleCoin is the memecoin that's unstoppable!  With its vibrant community and meme magic, it combines humor with blockchain tech to create value. Built for fun, it's also deflationary: every transaction reduces supply!  Join the InvincibleCoin army for laughs and gains. It's more than a coin; it's a movement!  Get"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INV>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INV>>(v4);
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

