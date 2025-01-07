module 0x3e134bdaf948b9164e1657b826641658898d1631ba6ffc40453d3a52e98382d6::uiauia {
    struct UIAUIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIAUIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UIAUIA>(arg0, 6, b"UIAUIA", b"UIA UIA", x"5549412055494120554941205549412055494120554941205549412055494120554941205549410a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pt_R9isa_Pj_Vqxsn_Y45i_Vh_Ky_YW_Cbb1j_Kt3q_VXFY_5tr_BDCE_9f3dec266c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UIAUIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UIAUIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

