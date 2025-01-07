module 0x5b65221db103a08dbcb2a6962e27410f20b408d6d17813fff700a60887f953e0::four {
    struct FOUR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOUR>, arg1: 0x2::coin::Coin<FOUR>) {
        0x2::coin::burn<FOUR>(arg0, arg1);
    }

    fun init(arg0: FOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOUR>(arg0, 6, b"FOUR", b"FOURSUILP", b"JUST FOUR SUI LP", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOUR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOUR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

