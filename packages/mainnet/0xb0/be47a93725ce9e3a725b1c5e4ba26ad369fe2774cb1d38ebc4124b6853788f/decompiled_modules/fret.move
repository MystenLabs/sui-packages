module 0xb0be47a93725ce9e3a725b1c5e4ba26ad369fe2774cb1d38ebc4124b6853788f::fret {
    struct FRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRET>(arg0, 6, b"FRET", b"FRET THE CET", b"trend-setting street cat who loves to stir sh*t up, break the rules, and leave people laughing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3389_885a2412d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRET>>(v1);
    }

    // decompiled from Move bytecode v6
}

