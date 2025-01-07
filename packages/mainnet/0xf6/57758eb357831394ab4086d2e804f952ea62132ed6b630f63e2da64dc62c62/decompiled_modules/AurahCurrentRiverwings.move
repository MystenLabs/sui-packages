module 0xf657758eb357831394ab4086d2e804f952ea62132ed6b630f63e2da64dc62c62::AurahCurrentRiverwings {
    struct AURAHCURRENTRIVERWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHCURRENTRIVERWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAHCURRENTRIVERWINGS>(arg0, 0, b"COS", b"Aurah-Current Riverwings", b"The river of silence... the hidden of water... set forth in knowing....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Aurah-Current_Riverwings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURAHCURRENTRIVERWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAHCURRENTRIVERWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

