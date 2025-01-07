module 0x530a5f2985442cce6b3bd4b86efbe96c355ffe8f819cb79a2003f527ba4aa266::pango {
    struct PANGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANGO>(arg0, 6, b"PANGO", b"Pangolin", b"Meet Pango, the adorable newborn pangolin from Brookfield Zoo. Pangos story began in the summer of 2024, when their first wobbly steps were captured and shared online, quickly turning them into an Internet sensation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053063_1531c97b2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

