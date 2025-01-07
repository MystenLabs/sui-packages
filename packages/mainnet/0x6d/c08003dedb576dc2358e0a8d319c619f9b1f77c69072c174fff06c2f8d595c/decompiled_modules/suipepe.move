module 0x6dc08003dedb576dc2358e0a8d319c619f9b1f77c69072c174fff06c2f8d595c::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: 0x2::coin::Coin<SUIPEPE>) {
        0x2::coin::burn<SUIPEPE>(arg0, arg1);
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 2, b"suipepe", b"suipepe", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

