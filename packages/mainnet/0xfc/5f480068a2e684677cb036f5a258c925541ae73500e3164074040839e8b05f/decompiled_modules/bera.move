module 0xfc5f480068a2e684677cb036f5a258c925541ae73500e3164074040839e8b05f::bera {
    struct BERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERA>(arg0, 9, b"BERA", b"BERACHAIN", b"The MEME Bera.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CHaUWqRE23qD8DUfDkWh18ASAHSU4y2cWjn1RKRguef2.png?size=lg&key=546181")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BERA>>(0x2::coin::mint<BERA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BERA>>(v2);
    }

    // decompiled from Move bytecode v6
}

