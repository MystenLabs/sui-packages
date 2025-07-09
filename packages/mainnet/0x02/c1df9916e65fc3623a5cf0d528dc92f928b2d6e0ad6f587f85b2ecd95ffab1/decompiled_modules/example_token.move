module 0x2c1df9916e65fc3623a5cf0d528dc92f928b2d6e0ad6f587f85b2ecd95ffab1::example_token {
    struct EXAMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<EXAMPLE_TOKEN>, arg1: 0x2::coin::Coin<EXAMPLE_TOKEN>) {
        0x2::coin::burn<EXAMPLE_TOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<EXAMPLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EXAMPLE_TOKEN>>(0x2::coin::mint<EXAMPLE_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: EXAMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXAMPLE_TOKEN>(arg0, 9, b"EXAMPLE", b"Example Token", b"An example token created following Sui standards", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXAMPLE_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXAMPLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

