module 0x3648b4160c5f33c37e92fb9f11dbf0f0dd2ea95f863ee90d7c12b9d601c426c9::cinna {
    struct CINNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CINNA>(arg0, 9, b"CINNA", b"Cinnamorol", x"4368c3ba63204368c3ba632063696e6e61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3c0ab52-7fe6-44af-86c6-2b6ef4ad0af7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CINNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

