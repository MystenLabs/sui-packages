module 0x64d2eaaa4b3627f361e2ea11ee16ded3b641f403374a46dd1a01cb418ad7de28::IlluminatedAncientVision {
    struct ILLUMINATEDANCIENTVISION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILLUMINATEDANCIENTVISION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILLUMINATEDANCIENTVISION>(arg0, 0, b"COS", b"Illuminated Ancient Vision", b"With this sacred adornment, we honor the departed Architects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Illuminated_Ancient_Vision.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILLUMINATEDANCIENTVISION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILLUMINATEDANCIENTVISION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

