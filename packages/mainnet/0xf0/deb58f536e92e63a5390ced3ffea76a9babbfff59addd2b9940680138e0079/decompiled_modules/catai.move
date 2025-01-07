module 0xf0deb58f536e92e63a5390ced3ffea76a9babbfff59addd2b9940680138e0079::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATAI>(arg0, 6, b"CATAI", b"AI Cat", b"The first AI for Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000057641_5e0411acfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

