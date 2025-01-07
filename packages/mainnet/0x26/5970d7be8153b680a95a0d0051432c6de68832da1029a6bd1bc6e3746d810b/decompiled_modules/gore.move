module 0x265970d7be8153b680a95a0d0051432c6de68832da1029a6bd1bc6e3746d810b::gore {
    struct GORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORE>(arg0, 6, b"GORE", b"Grave Gore", x"477261766520476f72652028474f5245290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_M_Ms_J2_Dd_Ui3n_Wn_Rik_V_Pwif_FT_Sa_Dn_Co5w_Uk6esxtwk8w_B_55d0086a63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

