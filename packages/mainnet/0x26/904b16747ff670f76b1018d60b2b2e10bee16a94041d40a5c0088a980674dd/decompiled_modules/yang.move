module 0x26904b16747ff670f76b1018d60b2b2e10bee16a94041d40a5c0088a980674dd::yang {
    struct YANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YANG>(arg0, 6, b"YANG", b"Ying Yang Cat", b"Two mischievous feline friends intertwined like the ancient Ying-Yang representing harmony across blockchains where one token can't exist without  the other", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YING_YANG_CAT_2_785219b17d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

