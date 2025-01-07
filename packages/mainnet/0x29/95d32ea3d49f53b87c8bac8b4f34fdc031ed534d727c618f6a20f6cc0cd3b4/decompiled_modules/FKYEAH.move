module 0x2995d32ea3d49f53b87c8bac8b4f34fdc031ed534d727c618f6a20f6cc0cd3b4::FKYEAH {
    struct FKYEAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKYEAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKYEAH>(arg0, 0, b"COS", b"FK YEAH", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/FK_YEAH.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FKYEAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKYEAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

