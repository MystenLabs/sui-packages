module 0x30f288465d9a0d1ea84f0572abfe3023a4712ebebad4c66b07edf672bba28695::dgdg {
    struct DGDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGDG>(arg0, 9, b"DGDG", b"Aman", b"Anime dekho jaldi se", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/565ea55d-530b-41c5-85d4-3b09bc370eb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

