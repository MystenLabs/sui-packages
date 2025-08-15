module 0x7bff479be00074e26d6517e716037586ac481844ff0fbd288febc8c6dff322e9::gruta {
    struct GRUTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/35t5DPbwJtB1tpGiSnqedLwQomi94BRKVDPyTRLdbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRUTA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Gruta       ")))), trim_right(b"Snow Pig Gruta                  "), trim_right(b"Memecoin based on the real story of saving the piggy GRUTA just a few days before slaughter, and also featuring a unique AI agent BCG (Better Call GRUTA) that analyzes FUD and Fudders in X communities (top 20 projects from the letsbonk fun Hackathon). Based on this analysis, trading signals will appear soon            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUTA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUTA>>(v4);
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

