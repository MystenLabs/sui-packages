module 0xe75e9d0f08feff23a676c4a2fee060d26592309f454e356f17b092809cf40796::suixyz {
    struct SUIXYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXYZ>(arg0, 9, b"SUIXYZ", b"SUIXYZ", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIXYZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXYZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIXYZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIXYZ>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIXYZ>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXYZ>>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

