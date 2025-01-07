module 0x461fdc193ee0184f715cda3343d19316fbb51201b07ea131f1e99d729fd4a972::catoshi {
    struct CATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATOSHI>(arg0, 6, b"Catoshi", b"Catoshi Nakamoto", b"The cat, the myth, the legend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3142_b2ee83f3be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

