module 0x827512624ed69e79d9286a2147e8b4348ec9a82d358e3f794c71ebe8f15cd609::operaxxxcoin {
    struct OPERAXXXCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPERAXXXCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPERAXXXCOIN>(arg0, 6, b"OPERAXXXCOIN", b"OPERAXXXCOIN", b"my first sui coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPERAXXXCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPERAXXXCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

