module 0xb14541421056513c39e4809c4971c9a0539924988165579b2003dac9388e9661::stama {
    struct STAMA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STAMA>, arg1: 0x2::coin::Coin<STAMA>) {
        0x2::coin::burn<STAMA>(arg0, arg1);
    }

    fun init(arg0: STAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMA>(arg0, 2, b"STAMA", b"SuiTama", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STAMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STAMA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

