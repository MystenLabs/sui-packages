module 0x5b8282832da1efa28ccd932e578c630155d345413a9d5c936d4c4bac00a7f29d::kml {
    struct KML has drop {
        dummy_field: bool,
    }

    fun init(arg0: KML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KML>(arg0, 6, b"KML", b"Kamella", b"Not Kamala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kamella_SMG_2aec61625c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KML>>(v1);
    }

    // decompiled from Move bytecode v6
}

