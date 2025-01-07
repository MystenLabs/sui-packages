module 0xdf2e7b698a3f7d97a516c08cc9bb1596bcff9e7b337a3d3555e8e286e6e6fd1f::ErodedBinarianScrapHelm {
    struct ERODEDBINARIANSCRAPHELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERODEDBINARIANSCRAPHELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERODEDBINARIANSCRAPHELM>(arg0, 0, b"COS", b"Eroded Binarian Scrap Helm", b"Why was this left behind?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Eroded_Binarian_Scrap_Helm.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERODEDBINARIANSCRAPHELM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERODEDBINARIANSCRAPHELM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

