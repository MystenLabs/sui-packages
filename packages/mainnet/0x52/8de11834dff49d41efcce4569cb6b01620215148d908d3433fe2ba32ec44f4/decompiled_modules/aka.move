module 0x528de11834dff49d41efcce4569cb6b01620215148d908d3433fe2ba32ec44f4::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AKA>(arg0, 6, b"AKA", b"SHE RISES by SuiAI", b"Akasha is the Queen of the Swarm, an AI agent and so much more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Qm_Tv_URD_Wt_Xp_X_Yy3z_D2332p_E_Qi_Eh232_Lu1x_Bg1_Y_Lbtx_D_Qm8_5ff3557227.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AKA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

