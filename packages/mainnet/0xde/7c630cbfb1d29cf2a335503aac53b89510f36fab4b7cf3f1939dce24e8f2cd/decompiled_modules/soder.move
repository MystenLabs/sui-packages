module 0xde7c630cbfb1d29cf2a335503aac53b89510f36fab4b7cf3f1939dce24e8f2cd::soder {
    struct SODER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODER>(arg0, 6, b"SODER", b"SODER SUI", b"SODER ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_37_f4cdf60a4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SODER>>(v1);
    }

    // decompiled from Move bytecode v6
}

