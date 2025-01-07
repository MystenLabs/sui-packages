module 0xfac346bf4cbd8284cc76e76981abc9b30c0f2398cde2913e7b21ead99d1f6536::coin_a {
    struct COIN_A has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN_A>, arg1: 0x2::coin::Coin<COIN_A>) {
        0x2::coin::burn<COIN_A>(arg0, arg1);
    }

    fun init(arg0: COIN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_A>(arg0, 3, b"COIN_A", b"CA", b"learning for swap", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_A>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN_A>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

