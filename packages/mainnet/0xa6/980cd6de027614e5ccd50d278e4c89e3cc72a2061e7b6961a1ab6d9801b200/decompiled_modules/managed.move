module 0xa6980cd6de027614e5ccd50d278e4c89e3cc72a2061e7b6961a1ab6d9801b200::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: 0x2::coin::Coin<MANAGED>) {
        0x2::coin::burn<MANAGED>(arg0, arg1);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED>(arg0, 2, b"Badoo", b"BADOO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

