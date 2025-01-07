module 0xbcdb0703c9b65fb90b4da80c6e3cee1a6eef330099c524e38cf1f9f4785877c::suimeo {
    struct SUIMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEO>(arg0, 9, b"SUIMEO", b"Suimeo cat", b"Rizz cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/291626d1-8dd2-4fe1-8ba7-069f4b5629c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

