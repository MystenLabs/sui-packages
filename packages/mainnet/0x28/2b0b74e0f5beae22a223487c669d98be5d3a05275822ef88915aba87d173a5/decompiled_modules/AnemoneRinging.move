module 0x282b0b74e0f5beae22a223487c669d98be5d3a05275822ef88915aba87d173a5::AnemoneRinging {
    struct ANEMONERINGING has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANEMONERINGING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANEMONERINGING>(arg0, 0, b"COS", b"Anemone Ringing", b"This melody resplendent carries you... to the edge of the world...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Anemone_Ringing.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANEMONERINGING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANEMONERINGING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

