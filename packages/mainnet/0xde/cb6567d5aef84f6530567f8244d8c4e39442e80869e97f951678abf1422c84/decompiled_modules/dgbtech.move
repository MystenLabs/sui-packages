module 0xdecb6567d5aef84f6530567f8244d8c4e39442e80869e97f951678abf1422c84::dgbtech {
    struct DGBTECH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DGBTECH>, arg1: 0x2::coin::Coin<DGBTECH>) {
        0x2::coin::burn<DGBTECH>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DGBTECH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DGBTECH>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DGBTECH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGBTECH>(arg0, 0, b"dgbtech", b"DGBTECH", b"Releap Profile Token: dgbtech", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGBTECH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGBTECH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<DGBTECH>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DGBTECH> {
        0x2::coin::mint<DGBTECH>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

