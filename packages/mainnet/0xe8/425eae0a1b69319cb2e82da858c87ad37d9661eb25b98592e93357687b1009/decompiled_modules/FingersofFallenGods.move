module 0xe8425eae0a1b69319cb2e82da858c87ad37d9661eb25b98592e93357687b1009::FingersofFallenGods {
    struct FINGERSOFFALLENGODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINGERSOFFALLENGODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINGERSOFFALLENGODS>(arg0, 0, b"COS", b"Fingers of Fallen Gods", b"Closing... clasping... always... around you...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Fingers_of_Fallen_Gods.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINGERSOFFALLENGODS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINGERSOFFALLENGODS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

