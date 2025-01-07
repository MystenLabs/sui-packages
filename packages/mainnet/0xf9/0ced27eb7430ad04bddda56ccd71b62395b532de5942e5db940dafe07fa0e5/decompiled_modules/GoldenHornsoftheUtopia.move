module 0xf90ced27eb7430ad04bddda56ccd71b62395b532de5942e5db940dafe07fa0e5::GoldenHornsoftheUtopia {
    struct GOLDENHORNSOFTHEUTOPIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDENHORNSOFTHEUTOPIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENHORNSOFTHEUTOPIA>(arg0, 0, b"COS", b"Golden Horns of the Utopia", b"With this sacred adornment, we honor the departed Architects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Golden_Horns_of_the_Utopia.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDENHORNSOFTHEUTOPIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENHORNSOFTHEUTOPIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

