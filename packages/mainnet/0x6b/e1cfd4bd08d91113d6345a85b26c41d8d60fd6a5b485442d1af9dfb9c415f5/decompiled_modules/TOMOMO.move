module 0x6be1cfd4bd08d91113d6345a85b26c41d8d60fd6a5b485442d1af9dfb9c415f5::TOMOMO {
    struct TOMOMO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOMOMO>, arg1: 0x2::coin::Coin<TOMOMO>) {
        0x2::coin::burn<TOMOMO>(arg0, arg1);
    }

    fun init(arg0: TOMOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMOMO>(arg0, 9, b"TOMOMO", b"TOMOMO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMOMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMOMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOMOMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOMOMO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

