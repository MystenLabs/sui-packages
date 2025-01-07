module 0x6df995926438012430212c69fdec04ab8d003a024e44d230d09204f5f123e1bd::pippi {
    struct PIPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPI>(arg0, 9, b"PIPPI", b"pippi coin", b"Pippi is funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f65b2a1-72eb-4a75-b4d4-8aa2c01b627a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

