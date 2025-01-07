module 0xbf908945e014afa1720d6883d5b13c07b768696320c43dd92e6e29b2e22d5fc4::santachill {
    struct SANTACHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTACHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTACHILL>(arg0, 9, b"SANTACHILL", b"Santa Chill Guy", b"I'm not your typical Santa. No heavy red suit. No sleigh bells jingling 24/7. Nah. I'm Santa Chill Guy. Think of me as the holiday spirit with a relaxed vibe. I'm here on Solana, spreading joy without breaking a sweat. Presents? Sure. But only if you're cool enough to handle the chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FaBkQy6t1iuWt3ynEsUzFsa2mhpkLW7bGwR1id5Hpump.png?size=lg&key=03f45c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANTACHILL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTACHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTACHILL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

