module 0x6f457a60f3e9e51e46f66b4fc4a4decf8a55adf31cf0bb86dbee6cc3b3f127fa::suicult {
    struct SUICULT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICULT>, arg1: 0x2::coin::Coin<SUICULT>) {
        0x2::coin::burn<SUICULT>(arg0, arg1);
    }

    fun init(arg0: SUICULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICULT>(arg0, 2, b"SUICULT", b"SUIC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICULT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICULT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICULT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICULT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

