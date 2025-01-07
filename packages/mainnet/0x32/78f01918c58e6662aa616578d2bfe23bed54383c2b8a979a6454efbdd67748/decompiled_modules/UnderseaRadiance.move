module 0x3278f01918c58e6662aa616578d2bfe23bed54383c2b8a979a6454efbdd67748::UnderseaRadiance {
    struct UNDERSEARADIANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDERSEARADIANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDERSEARADIANCE>(arg0, 0, b"COS", b"Undersea Radiance", b"Grace from the depths.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Undersea_Radiance.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNDERSEARADIANCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDERSEARADIANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

