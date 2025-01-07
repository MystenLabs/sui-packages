module 0xd12d0dbe5c01f8ec8aff8b62d440b3b5c7ef9330e55878c3ee30381694ba57ef::whn_coin {
    struct WHN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHN_COIN>(arg0, 3, b"WHN", b"WHN", b"just for whn", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

