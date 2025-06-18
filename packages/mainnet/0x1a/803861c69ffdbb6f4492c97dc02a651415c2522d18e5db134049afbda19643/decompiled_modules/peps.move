module 0x1a803861c69ffdbb6f4492c97dc02a651415c2522d18e5db134049afbda19643::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPS>(arg0, 6, b"PEPS", b"PEPS Singer", x"24506570732073696e6765722066696e616e636520323032350a496e20746865207175696574206f66206120666f676779206e696768742c20612073696e676c652062656c6965766572277320666169746820696e20245065707320776173207465737465642e2054686520746f6b656e2c206e616d656420616674657220746865206c6567656e64617279205065707320576f726c642c20656d626f646965732061206d656d652063756c7475726520646565706c7920696e7465727477696e65642077697468204e6172656b2066617363696e6174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5062_d8988b5f81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

