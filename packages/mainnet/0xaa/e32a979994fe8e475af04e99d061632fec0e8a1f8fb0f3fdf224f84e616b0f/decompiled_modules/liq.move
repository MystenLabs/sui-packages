module 0xaae32a979994fe8e475af04e99d061632fec0e8a1f8fb0f3fdf224f84e616b0f::liq {
    struct LIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQ>(arg0, 6, b"LIQ", b"Liquor", b"Be water, be liquor, my friend. beliquoronsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_105042_73c648d09c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

