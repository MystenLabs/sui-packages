module 0x97467e5219c9ca012ff6327565726c79c74860cbdb00bc5ccd5fa7a89f93ee71::TreasuredNeckwear {
    struct TREASUREDNECKWEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREASUREDNECKWEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASUREDNECKWEAR>(arg0, 0, b"COS", b"Treasured Neckwear", b"A brooch, a keepsake... a distant smile is a promise to return...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Treasured_Neckwear.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASUREDNECKWEAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREASUREDNECKWEAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

