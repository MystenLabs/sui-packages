module 0xc9fcda24871509f4b1ea010dd382a8f8e01fe21d70282ea5913f59faef5d87d2::suichiro {
    struct SUICHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHIRO>(arg0, 6, b"SUICHIRO", b"SUICHIR0", b"Suichiro is all about good vibes, chill times, and smooth transactions. With his surfboard in one paw and a joint in the other, Suichiro surfs through the blockchain, spreading relaxation and decentralization to all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_20_29_13_1d94826d51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

