module 0x5ec1f192aabeb3066f8b13e011aebeb70a9ed11aa1891a0bb0c53b91199d4b86::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WSUI>, arg1: 0x2::coin::Coin<WSUI>) {
        0x2::coin::burn<WSUI>(arg0, arg1);
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 9, b"WSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

