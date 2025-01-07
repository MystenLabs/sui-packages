module 0x2f47616d25034ad9b18cd3e7fdc440caf8ed2c6f32cd79c68efaee1b3054ac43::xmas {
    struct XMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS>(arg0, 9, b"XMAS", x"f09d958f6d6173", x"68747470733a2f2f7777772e786d6173636f696e2e6c6f6c0a68747470733a2f2f782e636f6d2f586d6173436f696e58", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EVKeekMFvJdnfcWQSiWRodABpNaJHmcfGGDDeaYpump.png?size=lg&key=61140a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XMAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

