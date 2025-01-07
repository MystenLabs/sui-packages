module 0xa0d32b501afac0e6dff2030733919cee93623c3baa6c9a56280f5077d5f243ba::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 9, b"SDF", b"fcvbd", b"CVBCVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/815bc447-ecda-4db7-9fb7-18cf1537dba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

