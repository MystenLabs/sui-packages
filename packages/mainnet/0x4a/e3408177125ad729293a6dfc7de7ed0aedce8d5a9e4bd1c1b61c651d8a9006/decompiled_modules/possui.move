module 0x4ae3408177125ad729293a6dfc7de7ed0aedce8d5a9e4bd1c1b61c651d8a9006::possui {
    struct POSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSSUI>(arg0, 6, b"POSSUI", b"possui", b"first possum on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/is8jz_Hs_X_400x400_5c03fb707b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

