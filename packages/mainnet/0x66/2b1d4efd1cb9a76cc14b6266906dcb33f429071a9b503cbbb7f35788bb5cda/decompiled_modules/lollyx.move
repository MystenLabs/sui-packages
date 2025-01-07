module 0x662b1d4efd1cb9a76cc14b6266906dcb33f429071a9b503cbbb7f35788bb5cda::lollyx {
    struct LOLLYX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOLLYX>, arg1: 0x2::coin::Coin<LOLLYX>) {
        0x2::coin::burn<LOLLYX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOLLYX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOLLYX>>(0x2::coin::mint<LOLLYX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOLLYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLYX>(arg0, 9, b"Lollyx", b"LOLLYX", b"Test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLLYX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLYX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

