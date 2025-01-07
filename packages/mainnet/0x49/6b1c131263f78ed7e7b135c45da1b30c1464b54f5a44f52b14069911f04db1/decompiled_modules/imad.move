module 0x496b1c131263f78ed7e7b135c45da1b30c1464b54f5a44f52b14069911f04db1::imad {
    struct IMAD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IMAD>, arg1: 0x2::coin::Coin<IMAD>) {
        0x2::coin::burn<IMAD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IMAD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IMAD>>(0x2::coin::mint<IMAD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMAD>(arg0, 9, b"imad", b"IMAD", b"Test Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

