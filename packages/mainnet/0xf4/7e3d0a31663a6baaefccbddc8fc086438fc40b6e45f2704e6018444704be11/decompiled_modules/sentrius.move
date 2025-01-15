module 0xf47e3d0a31663a6baaefccbddc8fc086438fc40b6e45f2704e6018444704be11::sentrius {
    struct SENTRIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENTRIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENTRIUS>(arg0, 6, b"Sentrius", b"Sentrius AI", b"Trusted AI Security Solutions With SentriusAI With advanced AI-driven security and over 35 years of expertise in cybersecurity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2150_be83721a6a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENTRIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENTRIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

