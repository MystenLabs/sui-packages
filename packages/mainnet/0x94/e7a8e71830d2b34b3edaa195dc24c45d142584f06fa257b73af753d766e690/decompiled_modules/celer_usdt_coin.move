module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::celer_usdt_coin {
    struct CELER_USDT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELER_USDT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CELER_USDT_COIN>(arg0, 6, b"USDT", b"Tether USD", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CELER_USDT_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELER_USDT_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

