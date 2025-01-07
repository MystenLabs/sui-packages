module 0x7fd5c754171a28391f8c5e4b66dcab7481d3f64e0f8667afd43c8ded38c511ca::SUIWIFT {
    struct SUIWIFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIWIFT>, arg1: 0x2::coin::Coin<SUIWIFT>) {
        0x2::coin::burn<SUIWIFT>(arg0, arg1);
    }

    fun init(arg0: SUIWIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIFT>(arg0, 9, b"SUIWIFT", b"SUIWIFT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWIFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIWIFT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIWIFT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

