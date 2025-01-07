module 0xdb72c319d00dbffb1df12aef51e7ffca3a3254d986fc53e4ef410f0f452bb48f::everettfu_coin {
    struct EVERETTFU_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVERETTFU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVERETTFU_COIN>(arg0, 8, b"everettfu coin", b"everettfu coin", b"everettfu coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVERETTFU_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVERETTFU_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

