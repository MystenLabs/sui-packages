module 0xda2736e0d475f91974253dae7c515616f6e1fb45c5cfa8044939ecd19c5ba1e9::UnusedRig {
    struct UNUSEDRIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNUSEDRIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNUSEDRIG>(arg0, 0, b"COS", b"Unused Rig", b"A better city exists... respite from these grand devourers...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Unused_Rig.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNUSEDRIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNUSEDRIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

