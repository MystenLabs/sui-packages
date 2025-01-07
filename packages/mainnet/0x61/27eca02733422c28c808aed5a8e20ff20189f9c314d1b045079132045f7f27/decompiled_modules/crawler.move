module 0x6127eca02733422c28c808aed5a8e20ff20189f9c314d1b045079132045f7f27::crawler {
    struct CRAWLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAWLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAWLER>(arg0, 6, b"CRAWLER", b"Night Crawler", b"Kids don't try this shit at home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nc4_dc4e6178a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAWLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAWLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

