module 0xe18862f17377ec0fbfddcd18dd1372aea056ccfacccc6e5e9f3fcd4dc2d74db2::aria {
    struct ARIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIA>(arg0, 6, b"ARIA", b"Aria Cloud on SUI", b"Aria is a blue cloud born from the evaporation of ocean water, carrying the freshness and spirit of the vast seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3587_2c293428be.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

