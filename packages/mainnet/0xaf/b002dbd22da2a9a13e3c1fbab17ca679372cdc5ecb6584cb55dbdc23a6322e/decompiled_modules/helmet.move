module 0xafb002dbd22da2a9a13e3c1fbab17ca679372cdc5ecb6584cb55dbdc23a6322e::helmet {
    struct HELMET has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELMET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELMET>(arg0, 6, b"HELMET", b"Helmet Stays On", b"Helmet Stays On", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELMET>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELMET>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

