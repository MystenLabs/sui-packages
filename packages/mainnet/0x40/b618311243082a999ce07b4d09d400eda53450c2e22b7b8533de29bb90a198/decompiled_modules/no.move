module 0x40b618311243082a999ce07b4d09d400eda53450c2e22b7b8533de29bb90a198::no {
    struct NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO>(arg0, 6, b"NO", b"NO SUI", b"Everyone deserves $NO, not just Pacman's friends or whales.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xcdbe12611f18b43098202d45928c905b34736c06_21b5d15c5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NO>>(v1);
    }

    // decompiled from Move bytecode v6
}

