module 0xa90181d6dcc3757aa6cc3c354770fd8140fbddb9579d7ae64ab1b61f8a5aed0b::chik {
    struct CHIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIK>(arg0, 6, b"CHIK", b"CHIK SUI", b"PEEP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3380_6851bbae8c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

