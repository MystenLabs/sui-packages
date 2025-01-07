module 0x9b3ea7b7d686f2b63b33e6481316f667073efeb0a47b96be452c5fe4763f45a8::suigma_nuts {
    struct SUIGMA_NUTS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIGMA_NUTS>, arg1: 0x2::coin::Coin<SUIGMA_NUTS>) {
        0x2::coin::burn<SUIGMA_NUTS>(arg0, arg1);
    }

    fun init(arg0: SUIGMA_NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMA_NUTS>(arg0, 9, b"SUIGMA", b"Suigma Nuts", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGMA_NUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMA_NUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGMA_NUTS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIGMA_NUTS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

