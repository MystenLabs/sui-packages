module 0x4bf001c9d5988128f833778d37cccc35bf2e48ed9bd4f6284df38d9bc1eedaf::jnix {
    struct JNIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNIX>(arg0, 6, b"JNIX", b"Jnix", b"ji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a1234_1e004be7a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JNIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

