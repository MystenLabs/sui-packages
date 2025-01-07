module 0xfd92437441e77f7eb4fae0b0b5e4179cb3cc90932dba6825a5247b55c56f7bdb::cheetah {
    struct CHEETAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEETAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEETAH>(arg0, 6, b"Cheetah", b"Saudi Cheetah", x"5269636865737420636174202c206661737465737420636174202c2063757465737420636174202d2043686565746168210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Qc_Xnhm1_HK_Hkegn_E_Ax86_E_Jt_VWN_4_Tio6_DT_73n3_SR_Qnth_S_ba9c2edc2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEETAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEETAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

