module 0x221caed3837ead326ded749ef923698510fdaf498ff947a4cdf40525a1e794c7::hemps {
    struct HEMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMPS>(arg0, 6, b"HEMPS", b"Hempsss", b"Hemp'ss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9928_09ab8ec7de.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

