module 0x7e7503a7af4eb0a286a1cde31f738d07af7b012d045659b1b378c1bcff5405f::mi_coin {
    struct MI_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MI_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MI_COIN>>(0x2::coin::mint<MI_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MI_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MI_COIN>(arg0, 8, b"MI_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MI_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MI_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

