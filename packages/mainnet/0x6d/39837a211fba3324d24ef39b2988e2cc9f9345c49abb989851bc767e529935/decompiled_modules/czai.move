module 0x6d39837a211fba3324d24ef39b2988e2cc9f9345c49abb989851bc767e529935::czai {
    struct CZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CZAI>(arg0, 6, b"CZAI", b"CZAI", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/CZ_5_011ea98e51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CZAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

