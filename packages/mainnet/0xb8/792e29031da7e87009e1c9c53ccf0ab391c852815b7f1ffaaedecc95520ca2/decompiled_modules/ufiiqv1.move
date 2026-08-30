module 0xb8792e29031da7e87009e1c9c53ccf0ab391c852815b7f1ffaaedecc95520ca2::ufiiqv1 {
    struct UFIIQV1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFIIQV1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFIIQV1>(arg0, 0, b"UFIIQV1", b"Sui Blue Gift User FIIQV1", b"Sui Blue Gift Testnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UFIIQV1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UFIIQV1>>(0x2::coin::mint<UFIIQV1>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFIIQV1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

