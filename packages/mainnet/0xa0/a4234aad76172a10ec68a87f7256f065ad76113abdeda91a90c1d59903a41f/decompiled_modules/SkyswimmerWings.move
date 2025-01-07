module 0xa0a4234aad76172a10ec68a87f7256f065ad76113abdeda91a90c1d59903a41f::SkyswimmerWings {
    struct SKYSWIMMERWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYSWIMMERWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYSWIMMERWINGS>(arg0, 0, b"COS", b"Skyswimmer Wings", b"Jet the cloudwaves... skirt the wind current...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Skyswimmer_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYSWIMMERWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYSWIMMERWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

