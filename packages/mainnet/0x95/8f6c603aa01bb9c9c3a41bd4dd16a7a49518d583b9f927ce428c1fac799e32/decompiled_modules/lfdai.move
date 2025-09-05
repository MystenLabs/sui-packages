module 0x958f6c603aa01bb9c9c3a41bd4dd16a7a49518d583b9f927ce428c1fac799e32::lfdai {
    struct LFDAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LFDAI>, arg1: 0x2::coin::Coin<LFDAI>) {
        0x2::coin::burn<LFDAI>(arg0, arg1);
    }

    fun init(arg0: LFDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFDAI>(arg0, 6, b"LFDAI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFDAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFDAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LFDAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LFDAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

