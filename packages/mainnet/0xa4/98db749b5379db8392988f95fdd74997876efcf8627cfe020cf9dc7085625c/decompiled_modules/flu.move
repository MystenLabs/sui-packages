module 0xa498db749b5379db8392988f95fdd74997876efcf8627cfe020cf9dc7085625c::flu {
    struct FLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLU>(arg0, 6, b"FLU", b"Fluioki", b"https://t.me/fluioki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_02_56_50_d06bc53587.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

