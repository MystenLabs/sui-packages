module 0x537b0e256c50b38262f5663e50284a5c3f0b083ade5fe43c89a749f76863de4::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 6, b"FROGGY", b"froggy", b"Froggy is a laid-back and often humorous character known for his relaxed demeanor and occasional antics with his friends. The character gained significant attention online, evolving into the popular meme \"Pepe the frog\" Which has various interpretations", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FROGGY_ICON_1_0dfc0d529f_453dd1c153.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

