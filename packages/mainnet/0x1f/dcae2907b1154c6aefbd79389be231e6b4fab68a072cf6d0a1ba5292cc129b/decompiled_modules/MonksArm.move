module 0x1fdcae2907b1154c6aefbd79389be231e6b4fab68a072cf6d0a1ba5292cc129b::MonksArm {
    struct MONKSARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKSARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKSARM>(arg0, 0, b"COS", b"Monk's Arm", b"Ignite... explode... burn away the outsiders...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Monk's_Arm.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKSARM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKSARM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

