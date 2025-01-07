module 0x729a2cfacc85f08dbbb60b967114f63ab147ad4427b48679c498b7d829c49d82::ab {
    struct AB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AB>(arg0, 6, b"AB", b"Adam Back", b"Adam Back is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_T_Nm9_T7yk_U_Wye_Cih_Zbdeh_Pmi_Pefxjp_V1m_P_Wn_Yuueq3x_M_5cc9c6cdb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AB>>(v1);
    }

    // decompiled from Move bytecode v6
}

