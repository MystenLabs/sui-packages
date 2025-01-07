module 0xcea7daed6d95399c4b6cd8f441af3fbec0353951bd41175c5f3b834bfa5ddba9::PrimordialAcuity {
    struct PRIMORDIALACUITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIMORDIALACUITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMORDIALACUITY>(arg0, 0, b"COS", b"Primordial Acuity", b"Touch the resurrecting rain that washes these hollow temples...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Primordial_Acuity.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMORDIALACUITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMORDIALACUITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

