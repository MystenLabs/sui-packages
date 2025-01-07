module 0x943049e83a4b5e40e6cbbc2c5aeb5a61d29c28bae9a56a08c70ce5427ae59ef::kael777_coin {
    struct KAEL777_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAEL777_COIN>, arg1: 0x2::coin::Coin<KAEL777_COIN>) {
        0x2::coin::burn<KAEL777_COIN>(arg0, arg1);
    }

    fun init(arg0: KAEL777_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAEL777_COIN>(arg0, 6, b"KAEL777", b"Kael777Coin", b"Kael777 Coin is so cool", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAEL777_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAEL777_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAEL777_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KAEL777_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

