module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::dusdc {
    struct DUSDC has drop {
        dummy_field: bool,
    }

    public fun faucet(arg0: &mut 0x2::coin::TreasuryCap<DUSDC>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUSDC>>(0x2::coin::mint<DUSDC>(arg0, 1000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: DUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUSDC>(arg0, 6, b"DUSDC", b"m1n3 Demo USDC", b"Devnet OTC pay leg. NOT a real stablecoin.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUSDC>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DUSDC>>(v0);
    }

    // decompiled from Move bytecode v7
}

