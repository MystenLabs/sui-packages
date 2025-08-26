module 0x10fc7ebe2e251ecd1713871e2f60b2b4b4dc938cfcce7809da2a6379cbb0bdd::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BS8hUchfriYStQFxiGR953q5A2ef3jsSRtMsfphjBAGS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DRIP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DRIP        ")))), trim_right(b"DEGEN REINVESTMENT PROJECT      "), trim_right(b"DRIP is the meme stock that lets you flex your financial style while stacking gains. Every transaction fuels 100% buyback and burn, boosting value with every move. No waiting until 65this is wealth-building that rewards your hustle and keeps it . Stack, grow, and let your portfolio drip with style                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIP>>(v4);
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

