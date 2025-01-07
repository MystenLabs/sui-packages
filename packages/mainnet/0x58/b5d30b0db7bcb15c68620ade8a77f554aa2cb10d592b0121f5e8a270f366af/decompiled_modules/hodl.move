module 0x58b5d30b0db7bcb15c68620ade8a77f554aa2cb10d592b0121f5e8a270f366af::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 6, b"HODL", b"Half Orange Drinking Lemonade", b"Just an orange drinking a lemonade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4tr_CW_5r_J_400x400_ec09d62815.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

