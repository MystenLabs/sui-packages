module 0xddbc405dd443ff14af97a24b316690c27f88a183f3f95e99a11941a70651f1cd::mind {
    struct MIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIND>(arg0, 6, b"MIND", b"MindCoin", b"MindCoin ($MIND), a revolutionary memecoin with an integrated AI project. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Ey4zt_Vx_400x400_7972a68175.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

