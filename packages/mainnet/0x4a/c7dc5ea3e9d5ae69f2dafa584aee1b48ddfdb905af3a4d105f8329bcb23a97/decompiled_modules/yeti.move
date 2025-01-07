module 0x4ac7dc5ea3e9d5ae69f2dafa584aee1b48ddfdb905af3a4d105f8329bcb23a97::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 6, b"YETI", b"Yeti on Sui", b"Meet $YETI, the degenerate abominable snowman.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_Rru_Fge_Jano_J7e_Yg1y_F9qg1_Yv_Zs2_Wf_Rh_JZ_Wv_VG_Kpump_0e1001689e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

