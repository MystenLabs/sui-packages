module 0x8f38a2c53fc7ed8bc86549b2be295e64b84be8a3f88b3712c9e80f7c3caa9e6::bluepepe {
    struct BLUEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPEPE>(arg0, 9, b"PEPE", b"BLUE PEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUEPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BLUEPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

