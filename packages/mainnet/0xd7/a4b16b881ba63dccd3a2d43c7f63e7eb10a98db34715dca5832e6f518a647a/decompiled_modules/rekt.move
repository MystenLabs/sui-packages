module 0xd7a4b16b881ba63dccd3a2d43c7f63e7eb10a98db34715dca5832e6f518a647a::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REKT>, arg1: 0x2::coin::Coin<REKT>) {
        0x2::coin::burn<REKT>(arg0, arg1);
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKT>(arg0, 2, b"REKT", b"REKT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REKT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REKT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REKT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

