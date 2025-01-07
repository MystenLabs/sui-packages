module 0x64c52611057f18916138f6c6637a25a8bb0eb24700a88f2bde96ad4176d67983::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"Momo the Sui Planet", b"MOMO the sui planet aims to create a world full of creativity and the spirit of exploration. Our core philosophy is \"Go & Explore,\" encouraging young people to break boundaries, embrace curiosity, and discover new things, both in the real world and the digital world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Bqa_JAG_4_Xeb7_MVC_Ae_EB_9a_CM_Gj_PGN_2_Kse_N_Xb_Jko82w_U_Cq_454426399d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

