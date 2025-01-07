module 0xd2cff5540900a4eda441a405eb6629072603ef7da4643d92140a87e3afd068de::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIT>, arg1: 0x2::coin::Coin<SUIT>) {
        0x2::coin::burn<SUIT>(arg0, arg1);
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUIT (https://twitter.com/SuitOnSui)", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

