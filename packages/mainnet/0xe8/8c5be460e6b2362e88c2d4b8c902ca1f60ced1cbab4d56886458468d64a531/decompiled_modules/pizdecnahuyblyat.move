module 0xe88c5be460e6b2362e88c2d4b8c902ca1f60ced1cbab4d56886458468d64a531::pizdecnahuyblyat {
    struct PIZDECNAHUYBLYAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZDECNAHUYBLYAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZDECNAHUYBLYAT>(arg0, 6, b"PizdecNahuyBlyat", b"Pizdec-Nahuy-Blyat", b"What can you say about life in Russia? Pizdec-Nahuy-Blyat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_14_11_49_48_b04fb6a69b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZDECNAHUYBLYAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZDECNAHUYBLYAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

