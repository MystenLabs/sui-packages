module 0x19fa5d3bc461e86d8fe5062853aec27ffdcb530c94b6c314b3c9d6c91c94cad4::xusdc {
    struct XUSDC has drop {
        dummy_field: bool,
    }

    public fun burn_xusdc(arg0: &mut 0x2::coin::TreasuryCap<XUSDC>, arg1: 0x2::coin::Coin<XUSDC>) : u64 {
        0x2::coin::burn<XUSDC>(arg0, arg1)
    }

    fun init(arg0: XUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUSDC>(arg0, 6, b"xUSDC", b"xUSDC Token", b"Vault xUSDC Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XUSDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_xusdc(arg0: &mut 0x2::coin::TreasuryCap<XUSDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<XUSDC> {
        0x2::coin::mint<XUSDC>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

