module 0x81c0de8bc1a0c23e3348cfddaff51d0b1ff32502836e20fb8e922b8028c914ba::jsnt {
    struct JSNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSNT>(arg0, 6, b"JSNT", b"Jason Token", b"Get Jason Token $JSNT and be part of the most feared community of all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jason_Token_290e29c265.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

