module 0x3be6f24ab81ddf011faef4fceb0612b45ec45c0db7bffe3e3e6738cc6bf81fe0::suiffyy {
    struct SUIFFYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFFYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFFYY>(arg0, 6, b"SUIFFYY", b"SUIFFY", b"SUifyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_03_15_03_d5c5d42b03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFFYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFFYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

