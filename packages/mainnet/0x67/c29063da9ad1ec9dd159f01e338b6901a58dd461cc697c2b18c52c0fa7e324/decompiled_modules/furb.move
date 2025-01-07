module 0x67c29063da9ad1ec9dd159f01e338b6901a58dd461cc697c2b18c52c0fa7e324::furb {
    struct FURB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURB>(arg0, 9, b"FURB", b"FurBall", b"Playfully inspired by internet cat culture and the viral appeal of adorable, fuzzy animals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33f85b42-655b-4c2b-a041-98be3e38936e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FURB>>(v1);
    }

    // decompiled from Move bytecode v6
}

