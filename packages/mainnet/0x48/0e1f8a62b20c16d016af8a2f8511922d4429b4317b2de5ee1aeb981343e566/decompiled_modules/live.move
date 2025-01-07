module 0x480e1f8a62b20c16d016af8a2f8511922d4429b4317b2de5ee1aeb981343e566::live {
    struct LIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIVE>(arg0, 6, b"LIVE", b"LIVE IN VC", b"join me lets have fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nude_be7b2e7e8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

