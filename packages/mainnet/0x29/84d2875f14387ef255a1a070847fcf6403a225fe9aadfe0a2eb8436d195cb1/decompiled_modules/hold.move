module 0x2984d2875f14387ef255a1a070847fcf6403a225fe9aadfe0a2eb8436d195cb1::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HOLD>, arg1: 0x2::coin::Coin<HOLD>) {
        0x2::coin::burn<HOLD>(arg0, arg1);
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLD>(arg0, 6, b"HOLD", b"HOLD", b"holder is the winner", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOLD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HOLD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

