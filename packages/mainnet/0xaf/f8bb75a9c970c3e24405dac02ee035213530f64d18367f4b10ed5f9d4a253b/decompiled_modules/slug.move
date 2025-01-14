module 0xaff8bb75a9c970c3e24405dac02ee035213530f64d18367f4b10ed5f9d4a253b::slug {
    struct SLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUG>(arg0, 6, b"SLUG", b"AstroSlug", b"This lil fellas biggest dream is to go to space as the first Astronaut Slug, he trained his whole life for this, lets help him achieving his goal!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736888771641.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

