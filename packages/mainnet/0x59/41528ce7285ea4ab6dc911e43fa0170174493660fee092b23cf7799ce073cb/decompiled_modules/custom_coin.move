module 0x5941528ce7285ea4ab6dc911e43fa0170174493660fee092b23cf7799ce073cb::custom_coin {
    struct CUSTOM_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSTOM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUSTOM_COIN>(arg0, 8, b"CC", b"$CC", b"$CC is ...", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSTOM_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CUSTOM_COIN>>(0x2::coin::mint<CUSTOM_COIN>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSTOM_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

