module 0xcefaf6225d93147752c270af7246429fd1084ad402eb7f595540b31e356f1ea8::slug {
    struct SLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUG>(arg0, 6, b"SLUG", b"AstroSlug", b"He is a smoll fella with a big dream of becoming the first Astronaut Slug, he trained hard for this day, lets help him achieve this goal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_4_36e60e4908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

