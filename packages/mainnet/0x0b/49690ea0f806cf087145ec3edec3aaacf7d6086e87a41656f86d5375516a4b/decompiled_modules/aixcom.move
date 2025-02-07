module 0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom {
    struct AIXCOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIXCOM>, arg1: 0x2::coin::Coin<AIXCOM>) {
        0x2::coin::burn<AIXCOM>(arg0, arg1);
    }

    fun init(arg0: AIXCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIXCOM>(arg0, 9, b"AIXCOM", b"AIXCOM Token", b"AIXCOM token for the AIXCOM AI Agent", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXCOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIXCOM>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIXCOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIXCOM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

