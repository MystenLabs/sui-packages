module 0x959dbb85a69e73462264c320d5614c76352843aff5f1648b63c183ce6ebc9ddc::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BORED>, arg1: 0x2::coin::Coin<BORED>) {
        0x2::coin::burn<BORED>(arg0, arg1);
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 9, b"BORED", b"BORED", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BORED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BORED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BORED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

