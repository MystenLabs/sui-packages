module 0x177d53240c6e3143cc98b0730608af39311ba4f5737a74a7dffebc44f67f212b::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 6, b"Bakso", b"Disney Sumatran Tiger", b"Bakso, the newest Sumatran tiger cub at Disneys Animal Kingdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pq_M5v3_J82_Mbc_Py_VJG_7_Y3_Zw_Qjxix_S_Rbt11_Xk_Uj_Ne_Cc7_SP_a7478b0891.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

