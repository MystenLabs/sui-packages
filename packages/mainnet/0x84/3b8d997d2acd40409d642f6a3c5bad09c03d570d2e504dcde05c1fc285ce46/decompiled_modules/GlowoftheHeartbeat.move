module 0x843b8d997d2acd40409d642f6a3c5bad09c03d570d2e504dcde05c1fc285ce46::GlowoftheHeartbeat {
    struct GLOWOFTHEHEARTBEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOWOFTHEHEARTBEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOWOFTHEHEARTBEAT>(arg0, 0, b"COS", b"Glow of the Heartbeat", b"Sunken so low... yet rising... always rising...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Glow_of_the_Heartbeat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOWOFTHEHEARTBEAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOWOFTHEHEARTBEAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

