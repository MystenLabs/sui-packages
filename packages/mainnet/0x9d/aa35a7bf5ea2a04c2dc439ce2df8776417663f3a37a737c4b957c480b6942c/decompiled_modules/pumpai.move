module 0x9daa35a7bf5ea2a04c2dc439ce2df8776417663f3a37a737c4b957c480b6942c::pumpai {
    struct PUMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPAI>(arg0, 6, b"PUMPAI", b"PumpAI", b"The unofficial AI version of Pump.fun, the future of Sui Token Deployments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yn6th_J39_BFBA_3vtr_C1n_Cge8_Xqarq_F2_Caf9p_N_Cq_Eh_H8hy_d62ca1f4e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

