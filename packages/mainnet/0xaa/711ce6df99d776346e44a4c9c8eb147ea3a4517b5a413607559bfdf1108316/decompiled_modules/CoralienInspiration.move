module 0xaa711ce6df99d776346e44a4c9c8eb147ea3a4517b5a413607559bfdf1108316::CoralienInspiration {
    struct CORALIENINSPIRATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORALIENINSPIRATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORALIENINSPIRATION>(arg0, 0, b"COS", b"Coralien Inspiration", b"These shapes must have meaning... these thoughts, yes, in the sand...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Coralien_Inspiration.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORALIENINSPIRATION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORALIENINSPIRATION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

