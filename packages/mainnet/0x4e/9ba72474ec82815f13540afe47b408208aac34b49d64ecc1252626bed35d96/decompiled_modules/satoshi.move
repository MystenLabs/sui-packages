module 0x4e9ba72474ec82815f13540afe47b408208aac34b49d64ecc1252626bed35d96::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"SATOSHI", b"The Creator Of Bitcoin", b"The creator of BITCOIN $BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BANNER_dea204860b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

