module 0xc3d3542b5d43a7be20d8da317a126c6c18a1a1c2b7a0ea316d9132fcf71fb280::usdo {
    struct USDO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDO>, arg1: 0x2::coin::Coin<USDO>) {
        0x2::coin::burn<USDO>(arg0, arg1);
    }

    fun init(arg0: USDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDO>(arg0, 6, b"USDO", b"USDO", b"Awesome Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

