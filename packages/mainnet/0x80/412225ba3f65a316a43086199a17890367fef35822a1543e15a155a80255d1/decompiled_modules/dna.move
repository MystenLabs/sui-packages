module 0x80412225ba3f65a316a43086199a17890367fef35822a1543e15a155a80255d1::dna {
    struct DNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNA>(arg0, 6, b"DNA", b"CZ DNA", x"435a3a2042696e616e636520697320696e206d7920444e412e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VZ_7qebaeu_CKF_Ng_Lu_X_Zmmf_Ru5_Z2mrr32kd_Dkc_S1_TZZ_Bco_0cba10bdfd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

