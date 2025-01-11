module 0x9900a22a68008233ac76a285bfb630a13e57d4b74fd85444b87fa79006f8a8a6::suinet {
    struct SUINET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUINET>(arg0, 6, b"SUINET", b"SUINET by SuiAI", b"SUINET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250110_225201_7b5786a737_cd7e0675c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

