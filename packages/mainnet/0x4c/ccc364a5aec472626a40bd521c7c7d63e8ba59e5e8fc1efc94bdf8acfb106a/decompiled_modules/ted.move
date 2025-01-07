module 0x4cccc364a5aec472626a40bd521c7c7d63e8ba59e5e8fc1efc94bdf8acfb106a::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 6, b"TED", b"TEDDSUI", b"$TED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Rc_C8x93kndgz6_N_Cu_Q5_L1vkggs_Ne_S7_Rg_N_Vz_S_Ma_Cj_F_Poh_770f781af7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TED>>(v1);
    }

    // decompiled from Move bytecode v6
}

