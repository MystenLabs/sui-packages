module 0x47f721ef4e18353450ab0d8fb965c087b2d1d6a6bb6667446e1a63d02ab8cb18::squiggle {
    struct SQUIGGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIGGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIGGLE>(arg0, 6, b"Squiggle", b"SquiggleSui", b"A little wavy, a lot crazy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_080028876_c827a83554.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIGGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIGGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

