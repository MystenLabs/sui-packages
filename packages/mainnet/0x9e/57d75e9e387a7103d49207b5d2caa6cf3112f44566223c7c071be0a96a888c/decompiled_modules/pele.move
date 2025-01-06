module 0x9e57d75e9e387a7103d49207b5d2caa6cf3112f44566223c7c071be0a96a888c::pele {
    struct PELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PELE>(arg0, 6, b"PELE", b"Rei Pele by SuiAI", b"REI PELE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_3_0eb0978cda.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PELE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

