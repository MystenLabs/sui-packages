module 0xc9a5dac8768b73c8357b07b1189bbbf5728fc028885be41df985f89b2b20dbfc::kev {
    struct KEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEV>(arg0, 6, b"KEV", b"Coastal Kev", b"Coastal Kev is all about good vibes and sunny skies. With $KEV, youre not just holding a token youre joining a community that knows how to have fun and keep things breezy. Come hang out, enjoy the ride, and be part of Kevs journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Coastal_Kev_df7bc94e7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

