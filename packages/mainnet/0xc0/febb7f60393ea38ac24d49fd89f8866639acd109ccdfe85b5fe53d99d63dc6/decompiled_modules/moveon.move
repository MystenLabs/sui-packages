module 0xc0febb7f60393ea38ac24d49fd89f8866639acd109ccdfe85b5fe53d99d63dc6::moveon {
    struct MOVEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEON>(arg0, 6, b"Moveon", b"Move on", b"The new GEMS is coming ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241113_144731_5b48c04ca5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

