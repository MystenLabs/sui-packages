module 0x9bd1b8a63086830985c3824da0c1d8e781f86a1ac4a10879b3fe3f1ceebc4532::pang {
    struct PANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANG>(arg0, 6, b"PANG", b"Xiaopang Chinese Dog", x"4a75737469636520666f72205869616f50616e672c206865206469646e7420646f20616e797468696e672077726f6e67200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tu8qh_g_T_400x400_e08ffd9381.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

