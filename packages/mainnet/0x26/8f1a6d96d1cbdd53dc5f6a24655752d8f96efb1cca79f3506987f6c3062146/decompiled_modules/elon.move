module 0x268f1a6d96d1cbdd53dc5f6a24655752d8f96efb1cca79f3506987f6c3062146::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"ELON ON SUI", b"He is righteous. He is fierce and wise. Guardian of the light. Warrior of heaven but he's humble. Protector of the trenches. His name is ELON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_U4_R_Uo_FUL_9_A757w_Z4b_C6_Dv_U7_Y_Li_S4_VHVAX_2t5_GQMRB_Wr_e356d6d060.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

