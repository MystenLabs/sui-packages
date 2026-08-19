module 0xa5d1bd67ed9b69157119d6906de8e1d94e53249a99a5381f8b5c39305c0ac212::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: 0x2::coin::Coin<USDC>) {
        0x2::coin::burn<USDC>(arg0, arg1);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"MUSDC", b"My USDC Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDC>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<USDC>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

