module 0xd9e3c7808f428e894f6368b8736b96aaf1fec369cda279c1c5ebb9ade75b19a4::geor {
    struct GEOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEOR>(arg0, 6, b"GEOR", b"GEORGE", b"Quit jerkin' and chill with GEORGE, the only frog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GEOR_6dc0a3e2b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

