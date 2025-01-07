module 0xae394cafe7b13a89bf11ba47a6e89665343422390be5bc83eb3cd2c80628f49f::slug {
    struct SLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUG>(arg0, 6, b"SLUG", b"SLUGGARDO", b"Sluggards - the sui slug millionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240928_154123_946_771519ba06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

