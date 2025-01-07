module 0x7cf1dc5e098e61f123de6f5bd8f4f01fc60d424e85d809cb475fc908c252951f::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 6, b"Kekius", b"Kekius Maximus", b"Elons new Profile! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024569_8c7ef96e44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

