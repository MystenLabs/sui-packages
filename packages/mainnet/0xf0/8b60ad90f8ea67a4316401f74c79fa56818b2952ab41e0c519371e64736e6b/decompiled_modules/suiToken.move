module 0xf08b60ad90f8ea67a4316401f74c79fa56818b2952ab41e0c519371e64736e6b::suiToken {
    struct SUITOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITOKEN>, arg1: 0x2::coin::Coin<SUITOKEN>) {
        0x2::coin::burn<SUITOKEN>(arg0, arg1);
    }

    fun init(arg0: SUITOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOKEN>(arg0, 6, b"FUSDT", b"fcihpy token", b"fcihpy test move token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITOKEN>>(v1);
        let v3 = &mut v2;
        mint(v3, 100000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITOKEN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

