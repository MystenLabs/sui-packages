module 0x283e34cf657702d79381a1f6f50bf1ee3cded06606c9c1a12cf1eb1817733b0::htuah {
    struct HTUAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTUAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTUAH>(arg0, 6, b"HTUAH", b"Hasbulla Tuah", b"Hasbulla with the HAWK TUA. Dex paid on bonding.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S_Bqvq_Yy2_EWBG_7_EZLG_Qb_T_Am_Ru8_K4ypdfs_Ymu5oe5_Dg6a_Q_ca042a86bf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTUAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTUAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

