module 0xe62794cabba7a7736c5e6fcf109b89cc5d5a3cafd38bbfd7534c677c8fcf9ab9::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: 0x2::coin::Coin<MY_COIN>, arg1: &mut 0x2::coin::TreasuryCap<MY_COIN>) {
        0x2::coin::burn<MY_COIN>(arg1, arg0);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 9, b"TEST", b"Test Token 9", b"TEST token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to(arg0: address, arg1: u64, arg2: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg2, arg1, arg3), arg0);
    }

    // decompiled from Move bytecode v6
}

