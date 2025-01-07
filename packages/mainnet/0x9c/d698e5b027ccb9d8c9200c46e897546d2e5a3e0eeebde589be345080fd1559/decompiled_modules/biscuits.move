module 0x9cd698e5b027ccb9d8c9200c46e897546d2e5a3e0eeebde589be345080fd1559::biscuits {
    struct BISCUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISCUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISCUITS>(arg0, 6, b"Biscuits", b"Biscuits The Seal", x"426973637569747320546865205365616c206f6e20535549212057686572652077652062656c6f6e67210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_Ao_WU_Uc7_Kxc7m_Rf_SC_Tb_N4_Ltsb_J5gys_W_Xb_Y3_U_Vho_Epump_2f696329f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISCUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISCUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

