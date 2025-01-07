module 0xb2833f157fc47a5a4bd3129057bfc62f859ab172004f00df6c47dc6d852249d0::GraceoftheMountainTrove {
    struct GRACEOFTHEMOUNTAINTROVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEMOUNTAINTROVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEMOUNTAINTROVE>(arg0, 0, b"COS", b"Grace of the Mountain Trove", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Mountain_Trove.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEMOUNTAINTROVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEMOUNTAINTROVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

