module 0x72ad5aa20b6e71e2f464ec093a22c3e288d1cbe05e2413a0ff68477e257b8e0c::duong {
    struct DUONG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUONG>, arg1: 0x2::coin::Coin<DUONG>) {
        0x2::coin::burn<DUONG>(arg0, arg1);
    }

    fun init(arg0: DUONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUONG>(arg0, 9, b"DUONG", b"Duong Token", b"This is a dummy token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUONG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUONG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

