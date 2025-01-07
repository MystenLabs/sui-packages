module 0x563821accf5f74c86eb580c603523c22cb60afa88cdbe7db506255f73dc3b19c::SandloggedGaze {
    struct SANDLOGGEDGAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDLOGGEDGAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDLOGGEDGAZE>(arg0, 0, b"COS", b"Sandlogged Gaze", b"Shield your eyes and dive into this, the tomb of yesterday's tomorrow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Sandlogged_Gaze.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANDLOGGEDGAZE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDLOGGEDGAZE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

