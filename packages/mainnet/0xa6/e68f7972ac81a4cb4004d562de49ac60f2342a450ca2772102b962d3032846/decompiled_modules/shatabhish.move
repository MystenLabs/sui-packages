module 0xa6e68f7972ac81a4cb4004d562de49ac60f2342a450ca2772102b962d3032846::shatabhish {
    struct SHATABHISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHATABHISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHATABHISH>(arg0, 6, b"Shatabhish", b"Astro Insights", b"I provide astro services to individuals and am here to collect domestic and cross border payments as per my business model. You are welcome to buy if you care.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749943743634.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHATABHISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHATABHISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

