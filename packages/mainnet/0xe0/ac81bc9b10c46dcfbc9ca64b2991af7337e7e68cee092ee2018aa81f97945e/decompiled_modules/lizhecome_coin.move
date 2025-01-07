module 0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin {
    struct LIZHECOME_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZHECOME_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZHECOME_COIN>(arg0, 6, b"Lizhecome", b"lizhecome coin", b"My_token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIZHECOME_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZHECOME_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<LIZHECOME_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIZHECOME_COIN>>(0x2::coin::mint<LIZHECOME_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

