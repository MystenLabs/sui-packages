module 0xe96cefcc28b5f1f8a89bd258906a8cde65aa6c2206ffd858dd92dd74087c4c41::pulseai {
    struct PULSEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULSEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULSEAI>(arg0, 6, b"PULSEAI", b"Pulse Ai Protocol", b"Pulse Protocol AI is an AI SaaS platform that allows you to build custom AI agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_HQ_Qkx_W7y_TRLHH_6_Pye_Zw_UDW_Ab_HVQ_6_NB_Yv25z5qo_JC_Kpf_17b78d81a2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULSEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULSEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

