module 0x88909a20c9e805b760f28672c76e1706379cc331aa3e09f415c0b389dcb2d2f9::harris {
    struct HARRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRIS>(arg0, 6, b"HARRIS", b"harris", x"48617272697320666f7220507265736964656e74203230323421204f6e636520426964656e2071756974732c204861727269732077696c6c2074616b656f66662120547275737420576f6d616e21210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000395_357970feab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

