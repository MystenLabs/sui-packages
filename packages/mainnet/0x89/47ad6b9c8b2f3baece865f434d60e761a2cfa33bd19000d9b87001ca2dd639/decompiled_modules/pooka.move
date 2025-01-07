module 0x8947ad6b9c8b2f3baece865f434d60e761a2cfa33bd19000d9b87001ca2dd639::pooka {
    struct POOKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKA>(arg0, 6, b"Pooka", b"Bullish Pooka", b"A bullish Pooka on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951627228.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

