module 0xa4166222c8e5ef96c7699857067a2bde040907a5a0108845fee34a081795a6f9::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIMOON>, arg1: 0x2::coin::Coin<SUIMOON>) {
        0x2::coin::burn<SUIMOON>(arg0, arg1);
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 2, b"SUIMOON", b"SUIB", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIMOON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

