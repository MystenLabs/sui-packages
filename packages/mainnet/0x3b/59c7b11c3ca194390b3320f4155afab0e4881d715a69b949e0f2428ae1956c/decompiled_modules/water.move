module 0x3b59c7b11c3ca194390b3320f4155afab0e4881d715a69b949e0f2428ae1956c::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: 0x2::coin::Coin<WATER>) {
        0x2::coin::burn<WATER>(arg0, arg1);
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 2, b"WATER", b"WATER", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WATER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

