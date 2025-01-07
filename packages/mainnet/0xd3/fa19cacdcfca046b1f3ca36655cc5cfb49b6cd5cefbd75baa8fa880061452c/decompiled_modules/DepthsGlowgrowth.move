module 0xd3fa19cacdcfca046b1f3ca36655cc5cfb49b6cd5cefbd75baa8fa880061452c::DepthsGlowgrowth {
    struct DEPTHSGLOWGROWTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPTHSGLOWGROWTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPTHSGLOWGROWTH>(arg0, 0, b"COS", b"Depths Glowgrowth", b"Hooks of the Plain... dug deep in the shoulders...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Depths_Glowgrowth.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPTHSGLOWGROWTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPTHSGLOWGROWTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

