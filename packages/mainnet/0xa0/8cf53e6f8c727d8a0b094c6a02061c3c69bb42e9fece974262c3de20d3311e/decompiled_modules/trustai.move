module 0xa08cf53e6f8c727d8a0b094c6a02061c3c69bb42e9fece974262c3de20d3311e::trustai {
    struct TRUSTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUSTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUSTAI>(arg0, 6, b"TrustAI", b"TrustAI Bots", x"57656c636f6d6520746f205472757374414920426f74730a596f757220556c74696d6174652041492d44726976656e2054726164696e6720436f6d70616e696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trustai_183068fa6d.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUSTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUSTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

