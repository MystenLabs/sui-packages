module 0xffd3a762c1a90c552bb369cfd7d99396cef1542fe4911ce8e732c720a868f2ae::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 6, b"FOMO", b"Flying Orangutan Mixing Oatmeal", b"his cookin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ucx_B_Bv5iy7_VY_2_VK_Qrwh8gs_Nr97j4_X7jh_Cpp_K9_Fx_Em_Ds5_1_6bd2c2bd4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

