module 0xd2cfa99d2740ecdb8e20c54242f87b53b0d74fe296b721f3e31750f9c025ec63::suinet {
    struct SUINET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUINET>(arg0, 6, b"SUINET", b"SUINET by SuiAI", b"SUINET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250110_225201_d251bb1495.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

