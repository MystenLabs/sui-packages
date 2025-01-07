module 0x517a3f0a0aad41427d25f697c860a38f1dda481999845fff6c31398ca40b031::MarkoftheWise {
    struct MARKOFTHEWISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARKOFTHEWISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKOFTHEWISE>(arg0, 0, b"COS", b"Mark of the Wise", b"When the vanished ones fade... so too will this feeling...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Mark_of_the_Wise.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARKOFTHEWISE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKOFTHEWISE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

