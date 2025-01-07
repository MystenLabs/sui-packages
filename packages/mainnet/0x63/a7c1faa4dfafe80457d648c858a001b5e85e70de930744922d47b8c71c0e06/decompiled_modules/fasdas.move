module 0x63a7c1faa4dfafe80457d648c858a001b5e85e70de930744922d47b8c71c0e06::fasdas {
    struct FASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASDAS>(arg0, 6, b"FASDAS", b"31232", b"DSAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/60ba45cdbfb8afc79aad40fb_L86xy_LF_4_400x400_1e227adbe2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FASDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

