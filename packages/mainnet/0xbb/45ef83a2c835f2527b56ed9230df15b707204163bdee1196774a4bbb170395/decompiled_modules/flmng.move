module 0xbb45ef83a2c835f2527b56ed9230df15b707204163bdee1196774a4bbb170395::flmng {
    struct FLMNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLMNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLMNG>(arg0, 6, b"FLMNG", b"Flamingo", b"Yessssss..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1188_55251e2c91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLMNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLMNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

