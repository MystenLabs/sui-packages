module 0x92a4aefa241843adafd70d372da3cc97ed4a89360ffe3e819b6c7d4afe7aa89f::yetti {
    struct YETTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETTI>(arg0, 6, b"YETTI", b"SUIYETI", b"SUI YETTI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733969670222.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YETTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

