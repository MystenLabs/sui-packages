module 0xc9b5cd3a680c12de2a0f135e3379cd11d574e290ad20a5740f933bbdab92c813::tmbl {
    struct TMBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMBL>(arg0, 9, b"TMBL", b"TEAM BULL", b"Team for the Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/501ef2be-94a4-4065-9e2f-576b8a2c0720.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

