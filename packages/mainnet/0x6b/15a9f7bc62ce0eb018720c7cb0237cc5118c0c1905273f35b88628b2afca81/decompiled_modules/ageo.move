module 0x6b15a9f7bc62ce0eb018720c7cb0237cc5118c0c1905273f35b88628b2afca81::ageo {
    struct AGEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGEO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGEO>(arg0, 6, b"AGEO", b"Agento", b"First Ai Agent by Heisenberg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/6b78507a7edc421e60ce3ba99e1e4b05_c17c98d3cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGEO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGEO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

