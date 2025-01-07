module 0x7bec64c2d8794f352f416a592bcf484930daf0dfe2e2e793fd513b9213e44bfd::BinarianScrapHelm {
    struct BINARIANSCRAPHELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINARIANSCRAPHELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINARIANSCRAPHELM>(arg0, 0, b"COS", b"Binarian Scrap Helm", b"Unclear what it does. Seems important.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Binarian_Scrap_Helm.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINARIANSCRAPHELM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINARIANSCRAPHELM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

