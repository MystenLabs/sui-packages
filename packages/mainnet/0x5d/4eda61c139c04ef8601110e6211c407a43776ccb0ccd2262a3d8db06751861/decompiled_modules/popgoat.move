module 0x5d4eda61c139c04ef8601110e6211c407a43776ccb0ccd2262a3d8db06751861::popgoat {
    struct POPGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPGOAT>(arg0, 6, b"POPGOAT", b"Goatseus Poppimus", b" Goatseus Poppimus popping on Sui, block by block!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dt_Wz93p_DU_Ze5c_Yq_B_Fm_Zj_Xq1wz_Zq_Z_Pyg_Ceox5d3ajpump_183a39cf82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

