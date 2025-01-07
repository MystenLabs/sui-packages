module 0x97502f6f3987857c0888ef3424f7ab34af9b8619f5038572bae560cfe4f1840::nusa {
    struct NUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUSA>(arg0, 6, b"NUSA", b"NewUSA", b"NEWUSA CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2024_11_05_T234431_232_a7aeff74a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

