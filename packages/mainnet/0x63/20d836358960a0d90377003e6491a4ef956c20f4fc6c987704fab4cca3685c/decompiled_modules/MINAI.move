module 0x6320d836358960a0d90377003e6491a4ef956c20f4fc6c987704fab4cca3685c::MINAI {
    struct MINAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINAI>, arg1: 0x2::coin::Coin<MINAI>) {
        0x2::coin::burn<MINAI>(arg0, arg1);
    }

    fun init(arg0: MINAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINAI>(arg0, 9, b"MINAI", b"MINAI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

