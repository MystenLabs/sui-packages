module 0x3e87cd36d70edeecc2e374ff06e40710466ce57ff022d39810719c3746d67172::ladyboyai {
    struct LADYBOYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYBOYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYBOYAI>(arg0, 6, b"LadyboyAI", b"Thailand First AI Ladyboy", b"Only we are dumb and retarded enough to mix AI with our fav ladyboys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Yq5_Je9_HNN_Lw_X2_Uo_Na_XD_Tgfk1z2_B_Pp_MT_2r_V5_Uxm_CH_7e_J_d1a0d73cb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYBOYAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYBOYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

