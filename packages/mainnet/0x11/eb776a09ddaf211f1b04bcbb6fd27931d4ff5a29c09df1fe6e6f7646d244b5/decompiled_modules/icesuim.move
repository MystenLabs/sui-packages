module 0x11eb776a09ddaf211f1b04bcbb6fd27931d4ff5a29c09df1fe6e6f7646d244b5::icesuim {
    struct ICESUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICESUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICESUIM>(arg0, 6, b"ICESUIM", b"ICE SUIM", b"FIRST ICE CREAM ON SUI. ICE SUIIIIIIM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZA_4_Lez5ms_Z7i_Ltatki_KSA_5_Gdnhs_Lx_F3g2sz7j67e_VD_1_F_f4373fcd38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICESUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICESUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

