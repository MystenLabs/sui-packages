module 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::tusdc {
    struct TUSDC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUSDC>, arg1: 0x2::coin::Coin<TUSDC>) {
        0x2::coin::burn<TUSDC>(arg0, arg1);
    }

    fun init(arg0: TUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSDC>(arg0, 6, b"TUSDC", b"Test USDC", b"USDC for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUSDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TUSDC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

