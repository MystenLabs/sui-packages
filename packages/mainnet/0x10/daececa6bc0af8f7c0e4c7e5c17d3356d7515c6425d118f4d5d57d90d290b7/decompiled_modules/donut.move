module 0x10daececa6bc0af8f7c0e4c7e5c17d3356d7515c6425d118f4d5d57d90d290b7::donut {
    struct DONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONUT>(arg0, 6, b"DONUT", b"DONUT TURBO", b"Welcome to Donut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973777331.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

