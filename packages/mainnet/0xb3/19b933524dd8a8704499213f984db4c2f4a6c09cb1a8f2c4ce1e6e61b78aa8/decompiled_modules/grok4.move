module 0xb319b933524dd8a8704499213f984db4c2f4a6c09cb1a8f2c4ce1e6e61b78aa8::grok4 {
    struct GROK4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C1mGDst8r74mpSm21Fj3VHb7JswKnfLNtdYgpAmopump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GROK4>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GROK4       ")))), trim_right(b"Grok 4                          "), trim_right(b"Elon Musks launch of Grok 4  the most powerful version yet  is upon us. This token was created on 22nd July 2024, making it the first-ever Grok 4 on PumpFun. Revived by a CTO led community well before the hype, it has no bundles, no cabal  just 12 months of pure history and organic growth. If you're hunting for the tru"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK4>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK4>>(v4);
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

