module 0x53c9fe3cedeb01133b0ca195bddb659607f5201e1eb855bd34353a8030258732::aipepe {
    struct AIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPEPE>(arg0, 2, b"AIPEPE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

