module 0x555905fd5fa5539a4119fdd936ded3397ad11b445b468ca9c7c1e22f514c11a8::etf {
    struct ETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETF>(arg0, 6, b"ETF", b"SUI ETF", b"Every TradeS fUCKED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731557621108.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

