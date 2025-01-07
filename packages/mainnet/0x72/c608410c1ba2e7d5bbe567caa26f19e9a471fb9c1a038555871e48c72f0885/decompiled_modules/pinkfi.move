module 0x72c608410c1ba2e7d5bbe567caa26f19e9a471fb9c1a038555871e48c72f0885::pinkfi {
    struct PINKFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKFI>(arg0, 9, b"PINKFI", b"PinkMemeFI", b"Pink MemeFI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b6fa3f2-06ac-4dac-b6e9-e3de153e7a47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINKFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

