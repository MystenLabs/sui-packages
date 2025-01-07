module 0x7bdf4ef9f74119481dfbf1057afe9acb63f5f14a7df86f40845a78aa2a02146d::catland {
    struct CATLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLAND>(arg0, 6, b"CATLAND", b"MC CATLAND", b"HAPPY MC CATLAND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3725_bef6427e6e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

