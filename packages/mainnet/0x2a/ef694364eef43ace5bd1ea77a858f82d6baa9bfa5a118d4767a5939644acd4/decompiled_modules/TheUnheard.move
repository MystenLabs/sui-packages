module 0x2aef694364eef43ace5bd1ea77a858f82d6baa9bfa5a118d4767a5939644acd4::TheUnheard {
    struct THEUNHEARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEUNHEARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEUNHEARD>(arg0, 0, b"COS", b"The Unheard", b"From the mire... listening... for...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_The_Unheard.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEUNHEARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEUNHEARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

