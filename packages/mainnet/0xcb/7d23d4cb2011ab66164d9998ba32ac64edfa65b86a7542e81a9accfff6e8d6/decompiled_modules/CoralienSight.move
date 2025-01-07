module 0xcb7d23d4cb2011ab66164d9998ba32ac64edfa65b86a7542e81a9accfff6e8d6::CoralienSight {
    struct CORALIENSIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORALIENSIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORALIENSIGHT>(arg0, 0, b"COS", b"Coralien Sight", b"Look. At this. A simple. Truth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Coralien_Sight.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORALIENSIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORALIENSIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

