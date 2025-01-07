module 0x3fdfe9cebd20bf554fa7e38a552e6e52e05976ce073003bad5c05f03b170669e::egrreg {
    struct EGRREG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGRREG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGRREG>(arg0, 6, b"EGRREg", b"fzfezf", b"grege", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2178374_w1400h1400c1cx700cy350cxt0cyt0cxb1400cyb700_d598fe2d6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGRREG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGRREG>>(v1);
    }

    // decompiled from Move bytecode v6
}

