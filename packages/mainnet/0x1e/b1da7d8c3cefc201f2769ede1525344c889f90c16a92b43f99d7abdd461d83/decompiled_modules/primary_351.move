module 0x1eb1da7d8c3cefc201f2769ede1525344c889f90c16a92b43f99d7abdd461d83::primary_351 {
    struct PRIMARY_351 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_351>, arg1: 0x2::coin::Coin<PRIMARY_351>) {
        0x2::coin::burn<PRIMARY_351>(arg0, arg1);
    }

    public fun forge(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_351>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY_351> {
        0x2::coin::mint<PRIMARY_351>(arg0, arg1, arg2)
    }

    public entry fun forge_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_351>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY_351>>(0x2::coin::mint<PRIMARY_351>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIMARY_351, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY_351>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY_351>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY_351>>(v1);
    }

    // decompiled from Move bytecode v6
}

