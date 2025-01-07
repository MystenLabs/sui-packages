module 0xcca6c90657c967c8de2ff7957bdfbfe7bce5bc296ba0952deb2634abcf24955d::bubblo {
    struct BUBBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLO>(arg0, 6, b"Bubblo", b"BubbloS", b"Drifting droplet with zero sense of direction $Bubblo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_We2_UX_Npv_Tzk_K_Sxq_MZYD_Ec_Rnx1m_Xcr_H5p_Wozjotx_Q_Xa_SF_086b39ff37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

