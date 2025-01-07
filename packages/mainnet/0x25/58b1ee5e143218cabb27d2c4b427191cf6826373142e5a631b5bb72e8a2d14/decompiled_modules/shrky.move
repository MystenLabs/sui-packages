module 0x2558b1ee5e143218cabb27d2c4b427191cf6826373142e5a631b5bb72e8a2d14::shrky {
    struct SHRKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRKY>(arg0, 6, b"Shrky", b"Sharky", b"Meet Sharky! Your favorite blockchain friend! Join us as we explore the depths of the blockchain together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gm_bn_m_bm_af3f9d471b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

