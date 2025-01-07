module 0x5aa406302245984f44ecb13d1e4fbbc26d80b40bed807fc4cde9eceb1e13faf8::AncientsGaze {
    struct ANCIENTSGAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCIENTSGAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCIENTSGAZE>(arg0, 0, b"COS", b"Ancient's Gaze", b"It is not tech; it is nature-what makes us whole.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Ancient's_Gaze.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANCIENTSGAZE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCIENTSGAZE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

