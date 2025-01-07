module 0x4f8fe008bfe5835738cd97de7152595f4a3c2bd207c16fa117bd30f6324a5cd5::sunoo {
    struct SUNOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNOO>(arg0, 6, b"SUNOO", b"sunghoon", b"Sungshoon Baby Penguin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_25_20_17_29_58d541ce82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

