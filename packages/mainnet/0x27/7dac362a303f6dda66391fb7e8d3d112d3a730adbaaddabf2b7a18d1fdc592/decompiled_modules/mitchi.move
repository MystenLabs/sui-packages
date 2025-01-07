module 0x277dac362a303f6dda66391fb7e8d3d112d3a730adbaaddabf2b7a18d1fdc592::mitchi {
    struct MITCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITCHI>(arg0, 6, b"MITCHI", b"Mitchi", b"The most memeable KOL on the timeline.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SC_Fug2c_Gpuu3_M_Mg_Qgkfra8_Mf67j_R821_V9jm_DC_Pwruaj_C_5c49f1dbd8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MITCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

