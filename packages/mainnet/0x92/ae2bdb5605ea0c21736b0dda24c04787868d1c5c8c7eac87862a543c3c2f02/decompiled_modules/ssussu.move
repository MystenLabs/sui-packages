module 0x92ae2bdb5605ea0c21736b0dda24c04787868d1c5c8c7eac87862a543c3c2f02::ssussu {
    struct SSUSSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUSSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUSSU>(arg0, 6, b"SSUSSU", b"$SU$SU", b"SUSUCOIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8912_e3d120c1ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUSSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUSSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

