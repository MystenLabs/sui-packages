module 0xb0f0d13ddf763d45a7fa821a6c20c534f66d9f4edd826c5b78eb02ce6256447e::example {
    struct N21 has drop {
        dummy_field: bool,
    }

    struct EXAMPLE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<N21>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<N21>>(0x2::coin::mint<N21>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: EXAMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXAMPLE>(arg0, 9, b"N21", b"N21", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXAMPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<EXAMPLE>>(0x2::coin::mint<EXAMPLE>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXAMPLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

