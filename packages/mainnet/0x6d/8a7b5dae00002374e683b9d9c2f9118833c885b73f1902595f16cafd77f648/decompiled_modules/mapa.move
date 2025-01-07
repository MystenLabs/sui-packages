module 0x6d8a7b5dae00002374e683b9d9c2f9118833c885b73f1902595f16cafd77f648::mapa {
    struct MAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAPA>(arg0, 6, b"MAPA", b"Make America Pure Again", b"Cat Trump will Make America Purr Again!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032811_c2b05e0481.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

