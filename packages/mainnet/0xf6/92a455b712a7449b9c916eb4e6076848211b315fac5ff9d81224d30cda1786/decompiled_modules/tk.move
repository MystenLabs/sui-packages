module 0xf692a455b712a7449b9c916eb4e6076848211b315fac5ff9d81224d30cda1786::tk {
    struct TK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK>(arg0, 6, b"TK", b"Tack", b"Trend-following and dip-buying", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

