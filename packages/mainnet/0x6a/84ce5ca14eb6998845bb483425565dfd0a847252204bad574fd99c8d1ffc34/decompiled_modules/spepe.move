module 0x6a84ce5ca14eb6998845bb483425565dfd0a847252204bad574fd99c8d1ffc34::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: 0x2::coin::Coin<SPEPE>) {
        0x2::coin::burn<SPEPE>(arg0, arg1);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 2, b"SPEPE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SPEPE>(&mut v2, 100000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v2, v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

