module 0xe69357bd11d36a215d799cad24a7a293c91af8c61a664b70e296773bf5611f17::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 6, b"JERRY", b"Tom & Jerry", b"Why not buy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951870550.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JERRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

