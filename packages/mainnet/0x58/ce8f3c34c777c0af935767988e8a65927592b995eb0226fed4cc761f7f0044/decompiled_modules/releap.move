module 0x58ce8f3c34c777c0af935767988e8a65927592b995eb0226fed4cc761f7f0044::releap {
    struct RELEAP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RELEAP>, arg1: 0x2::coin::Coin<RELEAP>) {
        0x2::coin::burn<RELEAP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RELEAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RELEAP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: RELEAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RELEAP>(arg0, 0, b"releap", b"RELEAP", b"Releap Profile Token: releap", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RELEAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELEAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<RELEAP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RELEAP> {
        0x2::coin::mint<RELEAP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

