module 0xc92d1cbfae6db08e9304d7fefa8187e1c859f4f3708e034f3429bac63306702d::raise_pepe {
    struct RAISE_PEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RAISE_PEPE>, arg1: 0x2::coin::Coin<RAISE_PEPE>) {
        0x2::coin::burn<RAISE_PEPE>(arg0, arg1);
    }

    fun init(arg0: RAISE_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAISE_PEPE>(arg0, 9, b"RAISE_PEPE on Sui", b"RAISE_PEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAISE_PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAISE_PEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAISE_PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RAISE_PEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

