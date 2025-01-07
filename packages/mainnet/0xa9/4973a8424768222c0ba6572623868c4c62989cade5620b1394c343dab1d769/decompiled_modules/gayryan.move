module 0xa94973a8424768222c0ba6572623868c4c62989cade5620b1394c343dab1d769::gayryan {
    struct GAYRYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYRYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYRYAN>(arg0, 6, b"GAYRYAN", b"gay", b"ryan is gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_19_23_07_50_fotor_2024112010413_be21e75cf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYRYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYRYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

