module 0x43f47dfd77f6205e4bbb6b7871bd4f9b8de5bfee2152ef1b3754b7a0bd4ffea6::olliefarta {
    struct OLLIEFARTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLLIEFARTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BwJ9oSrWKSzZ5wXTiopEMw2asY2PnTo1wKW5TLZjpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OLLIEFARTA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OLLIEFART   ")))), trim_right(b"Ollie Farted                    "), trim_right(b"$OLLIE.FART launched from the tailwind of Ollie, a mischief-powered meme machine on Solana. With 100 million tokens locked, it's built on trust, chaos, and community. No presale, no VCsjust gas, memes, and moon potential. Backed by a loyal pack and fueled by fun, $OLLIE.FART is ready to rip.                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLLIEFARTA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLLIEFARTA>>(v4);
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

