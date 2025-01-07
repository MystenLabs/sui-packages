module 0xf697d6b5655c7571a642cdf585ce15f1c668493ac68e7ec63d09c5ad187cf934::kumo {
    struct KUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMO>(arg0, 6, b"KUMO", b"Kumo", b"the cat has entered the chat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X4f4_LN_7b_D_Dt_VKQM_44_Qz16_MCY_Xe_T9_Tr_MS_Pd_Z_Pn_Ao_E_Zu7d_d661215568.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

