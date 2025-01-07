module 0x9588f05bacb25d0c9baa5857a324a651c2daa77f94682aed909080ffe465b448::chillsui {
    struct CHILLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSUI>(arg0, 6, b"CHILLSUI", b"Just a Chill SUI", b"Just a chill SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_20_16_11_31_cca243e353.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

