module 0x65b63986e1c20a43656640a15ab84599400b94aa126b0ae3f87643fc709fc67d::TRUMPER {
    struct TRUMPER has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"TRUMPER", b"GETOUT", b"Official token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: TRUMPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<TRUMPER>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUMPER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TRUMPER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

