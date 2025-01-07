module 0x7096a4061f6a8518a66d30c2cd3109fd81b98fbf6245b45e93dcabdf77009df::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: 0x2::coin::Coin<SPEPE>) {
        0x2::coin::burn<SPEPE>(arg0, arg1);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 2, b"SPEPE", b"SPEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

