module 0x83541dc8284f3b4325a5e37d1a6ba30f5fc14e6ce8fd5c1f6c85b2baff3e330f::nail {
    struct NAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAIL>(arg0, 6, b"NAIL", b"SNAILS", x"4272696e67696e6720796f7520636f6d6d756e6974792c2076616c756520616e6420666169726e6573732e2057652061726520246e61696c206f6e20537569210a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zy_HW_Ik_WAB_Qsb_BV_b032103c54.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

