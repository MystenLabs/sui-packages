module 0x592c0b7737088757000b6c3297f76928c64ae422daf8b7c9c91848c80d2bc1e5::coin_one {
    struct COIN_ONE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN_ONE>, arg1: 0x2::coin::Coin<COIN_ONE>) {
        0x2::coin::burn<COIN_ONE>(arg0, arg1);
    }

    fun init(arg0: COIN_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_ONE>(arg0, 3, b"COIN_ONE", b"ONE", b"learning for swap", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_ONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_ONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_ONE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN_ONE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

