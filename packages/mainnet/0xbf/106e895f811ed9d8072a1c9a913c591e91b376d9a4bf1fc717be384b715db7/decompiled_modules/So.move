module 0xbf106e895f811ed9d8072a1c9a913c591e91b376d9a4bf1fc717be384b715db7::So {
    struct SO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SO>(arg0, 9, b"COOL", b"So", b"so cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzOfVlYXcAALg5K?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

