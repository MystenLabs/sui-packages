module 0x1494e9f8ab06b93a20d5956a04d49fb7f0569a86e1bf93ed2ba3cd186175905::popswife {
    struct POPSWIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSWIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSWIFE>(arg0, 6, b"POPSWIFE", b"POPCATS WIFE", b"Popcats wife", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3565_da13078171.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSWIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPSWIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

