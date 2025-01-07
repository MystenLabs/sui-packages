module 0x9d20ede2291fbfda36e7bc06c413a7a9cf772b400a1ed2f48a9a2a8583f45a10::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: 0x2::coin::Coin<PEPE>) {
        0x2::coin::burn<PEPE>(arg0, arg1);
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"PEPE on Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

