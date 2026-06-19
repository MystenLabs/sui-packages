module 0x7292baf0cfa84626d31e44b71673b9ad591597b5dee108e8e7bd7577a376d2a2::fusdc {
    struct FUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUSDC>(arg0, 6, b"fUSDC", b"Fanside USDC", b"Fanside platform stablecoin for minting and marketplace payments", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUSDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FUSDC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

