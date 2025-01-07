module 0x7d003df6fbfcec9c118eb4318cd3d67b99e79a11caa67d7b7fbc5b36c5e803c5::dialedin {
    struct DIALEDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIALEDIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIALEDIN>(arg0, 6, b"DIALEDIN", b"DIALED IN SUI", b"Unreal focus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4m_Ru_T3_FC_2_Lb1y_Z6_FTTET_3b_ZDA_Bqasvafbjt_U5p_F2pump_96607ac80f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIALEDIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIALEDIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

