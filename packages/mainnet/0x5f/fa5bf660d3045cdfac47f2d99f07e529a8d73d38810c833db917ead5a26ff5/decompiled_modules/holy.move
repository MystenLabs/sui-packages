module 0x5ffa5bf660d3045cdfac47f2d99f07e529a8d73d38810c833db917ead5a26ff5::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY>(arg0, 9, b"holy", b"Holy", b"holy CAT meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/58y23mKohBMkt1AuMSz9TYaUZEgdfQaNkp8CtaY5pump.png?size=xl&key=73a049")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

