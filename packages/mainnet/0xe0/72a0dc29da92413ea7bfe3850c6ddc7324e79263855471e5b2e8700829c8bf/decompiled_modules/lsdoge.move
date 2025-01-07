module 0xe072a0dc29da92413ea7bfe3850c6ddc7324e79263855471e5b2e8700829c8bf::lsdoge {
    struct LSDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LSDOGE>, arg1: 0x2::coin::Coin<LSDOGE>) {
        0x2::coin::burn<LSDOGE>(arg0, arg1);
    }

    fun init(arg0: LSDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSDOGE>(arg0, 2, b"LSDOGE", b"SUIG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LSDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LSDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LSDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

