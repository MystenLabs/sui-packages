module 0x60a56d9794155b634034779b2ad359b0c1a36c633ed78522e72aeb2a3b66ba2e::gfvpuve {
    struct GFVPUVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFVPUVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFVPUVE>(arg0, 0, b"GFVPUVE", b"Sui Blue Gift Owner FVPUVE", b"Sui Blue Gift mainnet Gift owner smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFVPUVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GFVPUVE>>(0x2::coin::mint<GFVPUVE>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFVPUVE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

