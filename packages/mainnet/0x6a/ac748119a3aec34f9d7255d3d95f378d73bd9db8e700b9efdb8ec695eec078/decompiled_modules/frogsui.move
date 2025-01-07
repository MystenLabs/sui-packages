module 0x6aac748119a3aec34f9d7255d3d95f378d73bd9db8e700b9efdb8ec695eec078::frogsui {
    struct FROGSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FROGSUI>, arg1: 0x2::coin::Coin<FROGSUI>) {
        0x2::coin::burn<FROGSUI>(arg0, arg1);
    }

    fun init(arg0: FROGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGSUI>(arg0, 6, b"FROG", b"Frog Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FROGSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FROGSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

