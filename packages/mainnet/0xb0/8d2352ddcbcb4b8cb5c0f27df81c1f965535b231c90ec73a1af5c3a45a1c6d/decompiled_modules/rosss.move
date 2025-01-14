module 0xb08d2352ddcbcb4b8cb5c0f27df81c1f965535b231c90ec73a1af5c3a45a1c6d::rosss {
    struct ROSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSSS>(arg0, 6, b"ROSSS", b"etert", b"weffq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbz_Rs_Jnas_AA_Tl_Xj_48a6f2b446.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

