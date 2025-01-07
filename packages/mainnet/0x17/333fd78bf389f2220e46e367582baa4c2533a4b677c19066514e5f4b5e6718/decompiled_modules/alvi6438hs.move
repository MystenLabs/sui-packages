module 0x17333fd78bf389f2220e46e367582baa4c2533a4b677c19066514e5f4b5e6718::alvi6438hs {
    struct ALVI6438HS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALVI6438HS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALVI6438HS>(arg0, 9, b"ALVI6438HS", b"Sexiai", b"Sexy Coins are inspired by sexual desire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7513048-02fe-4873-b80e-0c05f58e7bc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALVI6438HS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALVI6438HS>>(v1);
    }

    // decompiled from Move bytecode v6
}

