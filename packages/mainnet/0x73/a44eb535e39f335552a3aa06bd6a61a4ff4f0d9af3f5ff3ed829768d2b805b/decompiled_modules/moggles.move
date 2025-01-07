module 0x73a44eb535e39f335552a3aa06bd6a61a4ff4f0d9af3f5ff3ed829768d2b805b::moggles {
    struct MOGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGGLES>(arg0, 6, b"MOGGLES", b"Mr. Moggles", x"5354465520414e442053454e4420495420210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Feb_DH_2_Xcjc_V_Ru5_RT_7_Lpn_FW_Fo4vs_SR_Vzu_PE_Pv8vs_QE_7h_0a85310a0d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

