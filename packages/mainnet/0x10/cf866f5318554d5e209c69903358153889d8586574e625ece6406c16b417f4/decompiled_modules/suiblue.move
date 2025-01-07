module 0x10cf866f5318554d5e209c69903358153889d8586574e625ece6406c16b417f4::suiblue {
    struct SUIBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLUE>(arg0, 9, b"SUIBLUE", b"Blue eyed dog", b"A blue-eyed dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x53b7015c996f22c026fa320cff2110002771e55dd36307221c2a0f473107869b::blue::blue.png?size=lg&key=18c7f5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBLUE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLUE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

