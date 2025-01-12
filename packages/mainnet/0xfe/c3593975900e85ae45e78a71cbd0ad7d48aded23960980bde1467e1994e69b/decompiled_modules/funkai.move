module 0xfec3593975900e85ae45e78a71cbd0ad7d48aded23960980bde1467e1994e69b::funkai {
    struct FUNKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FUNKAI>(arg0, 6, b"FUNKAI", b"FUNKAI by SuiAI", b"FUNKAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250110_225201_0229762847.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUNKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

