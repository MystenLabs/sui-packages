module 0xe204313ef1d0957203ad8ffa4d57cf1e4a735372e86c0842c77a6feead011d27::suis_coin {
    struct SUIS_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIS_COIN>, arg1: 0x2::coin::Coin<SUIS_COIN>) {
        0x2::coin::burn<SUIS_COIN>(arg0, arg1);
    }

    fun init(arg0: SUIS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS_COIN>(arg0, 9, b"SUIS", b"SUIS COIN", b"SUIS token for Sui network", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIS_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIS_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIS_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

