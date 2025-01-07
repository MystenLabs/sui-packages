module 0x8a1e26df3a68467d82c38464ed3cf65c9289c393ec91d4f059a81a1885375b83::suidon {
    struct SUIDON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDON>, arg1: 0x2::coin::Coin<SUIDON>) {
        0x2::coin::burn<SUIDON>(arg0, arg1);
    }

    fun init(arg0: SUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDON>(arg0, 6, b"SUIDON", b"Posuidon (Twitter: @SuidonToken)", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

