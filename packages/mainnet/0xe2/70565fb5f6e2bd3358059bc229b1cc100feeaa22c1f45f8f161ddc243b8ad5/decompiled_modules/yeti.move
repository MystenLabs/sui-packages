module 0xe270565fb5f6e2bd3358059bc229b1cc100feeaa22c1f45f8f161ddc243b8ad5::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 6, b"YETI", b"Yeti on Sui", x"4d6565742024594554492c2074686520646567656e65726174652061626f6d696e61626c6520736e6f776d616e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_Rru_Fge_Jano_J7e_Yg1y_F9qg1_Yv_Zs2_Wf_Rh_JZ_Wv_VG_Kpump_048cec3b9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

