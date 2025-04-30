module 0xe98e215438d44f380b28b35d0e688a43075f9e674a717f615654a0dea616428f::asuiguy {
    struct ASUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIGUY>(arg0, 6, b"ASUIGUY", b"A sui guy", b"Just A Sui Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/er592x_4a455e8ed3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUIGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

