module 0x99d733502042b73f782fc168485d910a43e2d2d0ce5219a8a06bf967d563c5a2::main_coin {
    struct MAIN_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAIN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIN_COIN>>(0x2::coin::mint<MAIN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN_COIN>(arg0, 6, b"MAIN_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

