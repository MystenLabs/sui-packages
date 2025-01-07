module 0x3e30df26af79edf288d1a5fcdd1598db087c55e52f33684871f5a8580a3932e5::CanopyShadow {
    struct CANOPYSHADOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANOPYSHADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANOPYSHADOW>(arg0, 0, b"COS", b"Canopy Shadow", b"Aglow is the little one... alight with a quiet illumination...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Canopy_Shadow.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANOPYSHADOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANOPYSHADOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

