module 0xa5a83e7fe4208f0b4a2c83914ea4d78e86d776c29254cb2d9efe6553f91dd70a::AIFRENS {
    struct AIFRENS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIFRENS>, arg1: 0x2::coin::Coin<AIFRENS>) {
        0x2::coin::burn<AIFRENS>(arg0, arg1);
    }

    fun init(arg0: AIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIFRENS>(arg0, 9, b"AIFRENS", b"AIFRENS", b"https://suifrens.ai/icon.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIFRENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFRENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIFRENS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIFRENS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

