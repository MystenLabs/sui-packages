module 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::paint_coin {
    struct PAINT_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAINT_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAINT_COIN>>(0x2::coin::mint<PAINT_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PAINT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAINT_COIN>(arg0, 8, b"PAINT", b"Paint", b"SuiPlace Paint coins used to paint pixels", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAINT_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAINT_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

