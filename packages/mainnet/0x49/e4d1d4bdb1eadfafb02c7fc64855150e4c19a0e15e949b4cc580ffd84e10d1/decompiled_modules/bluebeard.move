module 0x49e4d1d4bdb1eadfafb02c7fc64855150e4c19a0e15e949b4cc580ffd84e10d1::bluebeard {
    struct BLUEBEARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBEARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBEARD>(arg0, 6, b"Bluebeard", b"BluebeardAI", x"4149204167656e74206f66204172742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_WS_Uxx_V_Qjb_G_Us_Tq6_Cofdgp4_QKG_2w6owba_Nr_P8_GM_Ur_KDV_9_19476c70dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBEARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEBEARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

