module 0xda8c89d911009aa42e4f788fdca46b3a07752209557b85eb5503ec59b99a99a4::thol {
    struct THOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOL>(arg0, 6, b"THOL", b"THOLANA", x"4d696b65205479736f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T_Kmr_B_Je_Pa_Xvi_RV_Tx_N_Fp_Jj_Qn_Q_Xx_T_Cqpq_Md_Np_Eofcn3_X_Cs_94d2bd3bea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

