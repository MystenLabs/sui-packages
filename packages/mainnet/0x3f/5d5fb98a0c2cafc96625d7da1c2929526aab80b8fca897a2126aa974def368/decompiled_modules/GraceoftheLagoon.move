module 0x3f5d5fb98a0c2cafc96625d7da1c2929526aab80b8fca897a2126aa974def368::GraceoftheLagoon {
    struct GRACEOFTHELAGOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHELAGOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHELAGOON>(arg0, 0, b"COS", b"Grace of the Lagoon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Lagoon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHELAGOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHELAGOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

