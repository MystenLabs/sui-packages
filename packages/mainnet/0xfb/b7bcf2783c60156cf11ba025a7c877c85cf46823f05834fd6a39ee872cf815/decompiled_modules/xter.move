module 0xfbb7bcf2783c60156cf11ba025a7c877c85cf46823f05834fd6a39ee872cf815::xter {
    struct XTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTER>(arg0, 6, b"XTER", b"xTerminal", b"xTerminal is a public intelligence terminal where participants input data to train AI, iteratively shaping a collective mind and evolving philosophy through knowledge vectors and belief systems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logogreen_d7ee24eeaf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

