module 0x3f7bb619a262899a5110a70f1e71b7d5decd444999a226967e563114c65d268b::grebo {
    struct GREBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREBO>(arg0, 6, b"Grebo", b"Punk dawgs", b"Anarchy in the trenches, the punk dawg movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/punk_dawgs_efb5d7c040.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

