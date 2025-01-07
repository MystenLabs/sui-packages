module 0xe0a23cb94f8d0cb504c61491db53e3375eecd20853fae76d85e51a6e82a9d8c3::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 6, b"BIAO", b"BIAO! SUI", x"4d6f6e64617920737472696b657320616761696e2c0a4249414f277320616c61726d206e657665722072616e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/biao_01_1_bf9082c598.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

