module 0x5b59708c395c11d0f0b131cfa5f50e1e680fc350bc605b1b58b0d2858c8904e4::crawler {
    struct CRAWLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAWLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAWLER>(arg0, 6, b"CRAWLER", b"Night Crawler", x"4b69647320646f6e2774207472792074686973207368697420617420686f6d650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nc4_dc4e6178a1_114bbe4bf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAWLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAWLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

