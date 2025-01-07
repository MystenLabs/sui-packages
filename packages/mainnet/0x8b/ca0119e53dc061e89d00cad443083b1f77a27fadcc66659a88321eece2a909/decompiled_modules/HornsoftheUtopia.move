module 0x8bca0119e53dc061e89d00cad443083b1f77a27fadcc66659a88321eece2a909::HornsoftheUtopia {
    struct HORNSOFTHEUTOPIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNSOFTHEUTOPIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNSOFTHEUTOPIA>(arg0, 0, b"COS", b"Horns of the Utopia", b"Guard this palace with your life... we mustn't be lost.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Horns_of_the_Utopia.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORNSOFTHEUTOPIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNSOFTHEUTOPIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

