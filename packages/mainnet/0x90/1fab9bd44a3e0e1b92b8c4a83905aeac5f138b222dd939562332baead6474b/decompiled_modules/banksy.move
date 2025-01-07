module 0x901fab9bd44a3e0e1b92b8c4a83905aeac5f138b222dd939562332baead6474b::banksy {
    struct BANKSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANKSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANKSY>(arg0, 6, b"BANKSY", b"TRUMP WIF BANKSY", x"4c65742042616e6b737920677265617420616761696e20210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W2_Aq_Prqv_YA_7t_E_Gc_Jxnjba_J7d2s4hz7t_NG_Gafe_F_Rw_VF_Ea_3b75036bb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANKSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANKSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

