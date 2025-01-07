module 0xe2a4a951e469d3807bece4d693d04ac6d4bbb2575cd2c132d5a729d36c68bc07::joozy {
    struct JOOZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOZY>(arg0, 6, b"JOOZY", b"JOOZY SUI", b"The 1st AI Assistant on SUI network. $JOOZY finally live on BlueMove! Try our AI assistant through website. Hold some $JOOZY token to unlock more features. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_23_26_07_be3b7570c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

