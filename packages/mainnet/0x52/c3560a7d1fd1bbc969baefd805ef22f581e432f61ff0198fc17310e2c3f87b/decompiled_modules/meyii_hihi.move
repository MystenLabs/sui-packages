module 0x52c3560a7d1fd1bbc969baefd805ef22f581e432f61ff0198fc17310e2c3f87b::meyii_hihi {
    struct MEYII_HIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEYII_HIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEYII_HIHI>(arg0, 9, b"MEYII_HIHI", b"Meyii", b"Hihi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43f29a5c-1a60-4bb8-b2e5-e6fd35b44337.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEYII_HIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEYII_HIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

