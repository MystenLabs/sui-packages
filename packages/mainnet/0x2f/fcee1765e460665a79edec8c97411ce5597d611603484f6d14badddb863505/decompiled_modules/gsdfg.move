module 0x2ffcee1765e460665a79edec8c97411ce5597d611603484f6d14badddb863505::gsdfg {
    struct GSDFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSDFG>(arg0, 9, b"GSDFG", b"REREW", b"SF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5260b6a-e8c9-40f4-8cc1-769f2c81aee2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSDFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSDFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

