module 0xc6430cb41200abf1c11cbec406d0748cb9cd35381ee1a300d3d59e4eaaa544dc::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBA>, arg1: 0x2::coin::Coin<SHIBA>) {
        0x2::coin::burn<SHIBA>(arg0, arg1);
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 2, b"SHIBA", b"SHIBA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

