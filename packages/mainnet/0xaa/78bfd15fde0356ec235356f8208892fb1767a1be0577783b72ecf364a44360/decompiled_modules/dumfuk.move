module 0xaa78bfd15fde0356ec235356f8208892fb1767a1be0577783b72ecf364a44360::dumfuk {
    struct DUMFUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMFUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMFUK>(arg0, 6, b"DUMFUK", b"SuiDumfuk", b"The dumbest fuk in the whole world. LDFG! Let's Dum Fuking Goose!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Ufiq_GFUZG_Ftrrt_C_Bs_Te3x6_Do_Hu5cck3xq8_F_Ucvsi_Zo_S_4a5838af1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMFUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMFUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

