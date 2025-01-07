module 0xf7d4be517d86560dbf980f9e8a792b3fab765c4860e7bd7bae0ea5388fbb4805::WanderersTint {
    struct WANDERERSTINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANDERERSTINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANDERERSTINT>(arg0, 0, b"COS", b"Wanderer's Tint", b"Miles seep into your skin... gather in your wake... unfurl before you...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Wanderer's_Tint.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WANDERERSTINT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANDERERSTINT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

