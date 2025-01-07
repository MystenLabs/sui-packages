module 0x32cd8c04348f7860f16ecedc9d7abad97746cb2d6331a3b42c96c94cd981d581::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Kittehcoin", x"66697273742063617420636f696e202d206b6974746568636f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XX_Cks5_P_Cvu1j_C_Co4_Qi_DR_2r_Ggusj_Ccf_KUR_Pv7_Rouv6_B_Ck_d34c4950ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

