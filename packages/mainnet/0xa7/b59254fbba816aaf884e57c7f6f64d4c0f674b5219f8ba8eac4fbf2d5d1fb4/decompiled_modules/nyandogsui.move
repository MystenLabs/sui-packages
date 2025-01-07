module 0xa7b59254fbba816aaf884e57c7f6f64d4c0f674b5219f8ba8eac4fbf2d5d1fb4::nyandogsui {
    struct NYANDOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYANDOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYANDOGSUI>(arg0, 6, b"NYANDOGSUI", b"NYAN DOG", b"Nyan Dog is a yellow dog that has a brown Poptart. He appears to be a relative of Nyan Cat and Tac Nyan. In the cancelled sequel, Nyan Dog & Friends. Nyan Dog married a Nyan dog named Miss. Nyan Dog. Unfortunately, not much else is known about other characters that would have appeared.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V7q5_Lny_Ay_Q_Zh_AG_6ma_QT_8k_R_Dd4z_K_Jv5_Nf_Y_Snd_GE_Qs_Fr_K5_eeb289270c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYANDOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYANDOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

