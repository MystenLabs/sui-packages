module 0x88b695866e64a74ac286fc48a61ce4164693e2bf1cd42790bd969737897eeebf::biscuits {
    struct BISCUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISCUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISCUITS>(arg0, 6, b"Biscuits", b"Biscuits The Seal", b"Biscuits The Seal on SUI! Where we belong!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_Ao_WU_Uc7_Kxc7m_Rf_SC_Tb_N4_Ltsb_J5gys_W_Xb_Y3_U_Vho_Epump_2f696329f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISCUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISCUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

