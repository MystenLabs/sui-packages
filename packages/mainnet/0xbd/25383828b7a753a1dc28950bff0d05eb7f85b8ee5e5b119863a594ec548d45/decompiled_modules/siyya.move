module 0xbd25383828b7a753a1dc28950bff0d05eb7f85b8ee5e5b119863a594ec548d45::siyya {
    struct SIYYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIYYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIYYA>(arg0, 9, b"SIYYA", b"Shamsi", b"For good user case", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d78f4d2-8c72-42fe-bea4-dbe01ffb597e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIYYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIYYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

