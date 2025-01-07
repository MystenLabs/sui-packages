module 0xe0df296b370c506af6509e55ea59eb91063aba9252ab5fc799f09ac52a79c43a::NANOSUI {
    struct NANOSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NANOSUI>, arg1: 0x2::coin::Coin<NANOSUI>) {
        0x2::coin::burn<NANOSUI>(arg0, arg1);
    }

    fun init(arg0: NANOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANOSUI>(arg0, 9, b"NANO", b"NANO SUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NANOSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NANOSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

