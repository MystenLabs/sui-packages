module 0x8f27b8f79e04fdd6d26ccd8f9fe874d07d3b3078e45ede7c021783d19676d34::girl {
    struct GIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRL>(arg0, 6, b"GIRL", b"girls", b"Love money girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/55c837b986d6bfe6b4396b9ff9004862_b490399eeb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

