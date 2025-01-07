module 0x9bdfb925fb0e940eaea921813f55141bb6470cbb518245e6cfbb0d679f010f66::TOPO {
    struct TOPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPO>(arg0, 9, b"CATTY", b"Catty Elon", b"Catty Elon Boost", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

