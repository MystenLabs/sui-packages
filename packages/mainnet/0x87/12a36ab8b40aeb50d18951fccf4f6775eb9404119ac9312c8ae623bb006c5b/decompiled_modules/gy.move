module 0x8712a36ab8b40aeb50d18951fccf4f6775eb9404119ac9312c8ae623bb006c5b::gy {
    struct GY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GY>(arg0, 8, b"GY", b"GuoyingCoin", b"Guoying2026Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun my_burn(arg0: &mut 0x2::coin::TreasuryCap<GY>, arg1: 0x2::coin::Coin<GY>) {
        0x2::coin::burn<GY>(arg0, arg1);
    }

    public entry fun my_mint(arg0: &mut 0x2::coin::TreasuryCap<GY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

