module 0xd106269a99c9a23f0fbf2169886a9e85300fdffc026d958dffe145e9ae061bff::eatass {
    struct EATASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EATASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EATASS>(arg0, 6, b"EatAss", b"Ass Worship Shorts", b"Just some ass worship shorts. Theres a link to purchase as the website ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1023_56130d5c9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EATASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EATASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

