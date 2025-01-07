module 0x6830da9fa029f2c3ddbde8bf03fea4a41584d0664fd598e76d8bcbe35d00a97e::shorse {
    struct SHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORSE>(arg0, 6, b"Shorse", b"SEAHORSE", b"SEAHORSE legend sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060740_25303e6602.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

