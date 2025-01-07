module 0x36d25f68325036264cb991cceee4f1f8c15bed0e4a46393e0a6b8658d6441416::hyperlambo {
    struct HYPERLAMBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HYPERLAMBO>, arg1: 0x2::coin::Coin<HYPERLAMBO>) {
        0x2::coin::burn<HYPERLAMBO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HYPERLAMBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HYPERLAMBO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HYPERLAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPERLAMBO>(arg0, 0, b"hyperlambo", b"HYPERLAMBO", b"Releap Profile Token: hyperlambo", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPERLAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPERLAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<HYPERLAMBO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HYPERLAMBO> {
        0x2::coin::mint<HYPERLAMBO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

