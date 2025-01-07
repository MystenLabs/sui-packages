module 0xef66ea2c1d74385bfe842dc9dc38342dfa5b457e4830fad60159d944aa19b516::rhnio {
    struct RHNIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHNIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHNIO>(arg0, 6, b"RHNIO", b"RIHNIO", b"The Rihnio is far stronger than the bull. Lets Rihnio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1a7ba16a_d4e1_4b9b_a4c9_76762d6c801b_a3c01dede2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHNIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHNIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

