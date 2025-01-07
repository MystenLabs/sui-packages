module 0x7f37dbb1f6f55ce30c3c0a18770191f14ad96a31360e94c34869b12e623cbc8c::saku {
    struct SAKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKU>(arg0, 6, b"SAKU", b"Saku Garden", b"Saku Garden transforms on SUI blockchain data into a beautiful 3D Blossom Tree, with real-time updates and AI-driven insights. Track holders, analyze trends, and explore token ecosystems like never before!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yug_UTCZJ_Du9_Udyg_HY_Ybq_Edcn62_S_Akx_J1n_FU_Mqn_R143_We_0510c21e7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

