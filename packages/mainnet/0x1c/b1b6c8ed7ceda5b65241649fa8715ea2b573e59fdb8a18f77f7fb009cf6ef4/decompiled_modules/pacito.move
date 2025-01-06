module 0x1cb1b6c8ed7ceda5b65241649fa8715ea2b573e59fdb8a18f77f7fb009cf6ef4::pacito {
    struct PACITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACITO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PACITO>(arg0, 6, b"PACITO", b"Paco by SuiAI", b"Gorilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/TA_Cp_Isw_B_Rs_Oa_Duc_RDJ_1z1g_59862c50c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PACITO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACITO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

