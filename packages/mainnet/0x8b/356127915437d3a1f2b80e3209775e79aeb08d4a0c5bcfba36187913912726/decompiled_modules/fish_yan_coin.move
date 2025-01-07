module 0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin {
    struct FISH_YAN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH_YAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH_YAN_COIN>(arg0, 9, b"Fish Yan Coin", b"Fish Yan Coin", b"Fish Yan coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISH_YAN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH_YAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

