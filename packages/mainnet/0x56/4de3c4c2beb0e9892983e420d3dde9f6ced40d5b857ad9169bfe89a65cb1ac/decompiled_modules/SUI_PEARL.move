module 0x564de3c4c2beb0e9892983e420d3dde9f6ced40d5b857ad9169bfe89a65cb1ac::SUI_PEARL {
    struct SUI_PEARL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_PEARL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_PEARL>>(0x2::coin::mint<SUI_PEARL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUI_PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PEARL>(arg0, 6, b"SUIPEARL", b"Sui Pearl", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_PEARL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PEARL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

