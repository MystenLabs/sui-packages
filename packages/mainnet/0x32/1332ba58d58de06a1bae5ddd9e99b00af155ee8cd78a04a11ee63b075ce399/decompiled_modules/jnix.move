module 0x321332ba58d58de06a1bae5ddd9e99b00af155ee8cd78a04a11ee63b075ce399::jnix {
    struct JNIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNIX>(arg0, 6, b"Jnix", b"Jnix 123", b"jnix", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a1234_586f4967bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JNIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

