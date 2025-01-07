module 0xd8bb3e94523b00e8cfc465457f31a5fd1d58aa0212a0beb2e6454daff7c2ebe6::grokle {
    struct GROKLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GROKLE>, arg1: 0x2::coin::Coin<GROKLE>) {
        0x2::coin::burn<GROKLE>(arg0, arg1);
    }

    fun init(arg0: GROKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKLE>(arg0, 9, b"GROKLE", b"Grokle", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROKLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GROKLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GROKLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

