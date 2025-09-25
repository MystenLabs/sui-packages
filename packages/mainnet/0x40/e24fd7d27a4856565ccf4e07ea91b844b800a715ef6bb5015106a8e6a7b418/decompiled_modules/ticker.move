module 0x40e24fd7d27a4856565ccf4e07ea91b844b800a715ef6bb5015106a8e6a7b418::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKER>(arg0, 6, b"Ticker", b"Garlic coin", b"First digital garlic coin , fresh and spicy like your wealth life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1758808754342.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

