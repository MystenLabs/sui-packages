module 0x9701aada41abb28edf7041660f2518c5b526277a161c8fc59034628826b7123e::musktaaaaaard {
    struct MUSKTAAAAAARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSKTAAAAAARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSKTAAAAAARD>(arg0, 6, b"MUSKTAAAAAARD", b"Musktaaaaaard", b"Musktaaaaaard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002565_a0f5f91256.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSKTAAAAAARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSKTAAAAAARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

