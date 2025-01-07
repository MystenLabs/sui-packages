module 0x10acb37f94b729bdd7b43aeac3409873a72087034e59c3136ad586482f79c9a2::shrimpy {
    struct SHRIMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMPY>(arg0, 6, b"Shrimpy", b"Sui Shrimpy", b"Small but packs a punch! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shrimp_1_4619a16245.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

