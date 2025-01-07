module 0x498edfc9e864d78d244315e514569ae842cb26c14cea75acb55224f74e933bbd::whn_coin {
    struct WHN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHN_COIN>(arg0, 3, b"WHN_FACUET", b"WHN", b"whn facuet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHN_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WHN_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

