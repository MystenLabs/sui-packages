module 0x1d2143583d678d1db687f5a608f1684389ea8a12b563e12ec97bdb06d71ed8a9::ultron {
    struct ULTRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ULTRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ULTRON>(arg0, 6, b"ULTRON", b"Ultron", b"Ultron will takeover sui space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Ssd1_E83_Yz2_ULF_An_M_Cwb_N_Wue5_Ls_KUN_Hp_Br_By_Zo2_T9_FSK_28faf3f398.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULTRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ULTRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

