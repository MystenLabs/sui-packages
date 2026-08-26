module 0xc030d3813bc2d387934b226a398e7e54f78fd3e138ffb7c1790f9a474140f03d::tk {
    struct TK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK>(arg0, 6, b"TK", b"TACK", b"Trend-following and dip-buying", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

