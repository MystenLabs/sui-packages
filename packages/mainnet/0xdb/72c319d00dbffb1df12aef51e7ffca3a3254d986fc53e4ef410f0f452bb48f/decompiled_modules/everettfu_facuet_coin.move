module 0xdb72c319d00dbffb1df12aef51e7ffca3a3254d986fc53e4ef410f0f452bb48f::everettfu_facuet_coin {
    struct EVERETTFU_FACUET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVERETTFU_FACUET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVERETTFU_FACUET_COIN>(arg0, 8, b"everettfu facuet coin", b"everettfu facuet coin", b"everettfu facuet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVERETTFU_FACUET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<EVERETTFU_FACUET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

