module 0x42fa383872c773b3be7626b521376c8e66477bb251e5b84fbad3dd14d77f1aaf::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"BULL", b"Battle Bul", b"The time is now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5af97584-b4a4-4071-8e9c-a491992fb621-IMG_20241005_191124_225.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

