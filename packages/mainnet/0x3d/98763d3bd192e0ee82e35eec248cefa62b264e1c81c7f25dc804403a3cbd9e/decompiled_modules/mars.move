module 0x3d98763d3bd192e0ee82e35eec248cefa62b264e1c81c7f25dc804403a3cbd9e::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 6, b"MARS", b"World's First AI Cat", x"576f726c642773204669727374204149204361740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcxwh1k_V_Pu_Vth_Uhjng5_Z6pocss_Gs_Wbj3m_Af8_S6a_J_La1is_b65bfaba37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

