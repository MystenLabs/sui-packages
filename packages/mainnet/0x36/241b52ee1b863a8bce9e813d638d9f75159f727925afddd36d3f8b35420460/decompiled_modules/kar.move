module 0x36241b52ee1b863a8bce9e813d638d9f75159f727925afddd36d3f8b35420460::kar {
    struct KAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAR>(arg0, 9, b"KAR", b"KARMAN SPA", b"KARMAN SPACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c801b0b-a9a0-449d-b8b5-b6542571fabb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

