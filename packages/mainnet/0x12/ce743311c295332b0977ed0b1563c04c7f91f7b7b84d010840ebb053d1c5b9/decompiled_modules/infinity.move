module 0x12ce743311c295332b0977ed0b1563c04c7f91f7b7b84d010840ebb053d1c5b9::infinity {
    struct INFINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFINITY>(arg0, 6, b"Infinity", b"Infinite", x"4265666f726520796f75207765726520626f726e2c200a416674657220796f75206469652c0a57686f2061726520796f753f200a0a496e66696e6974652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Northern_Lights_and_Ice_Cave_image_104180929a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFINITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

