module 0xf760e4dbfd2b367ed9307c408b832b776d0d07e89c0594ca2b6d7d98b82e0717::bog {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 6, b"BOG", b"BOG - The Frog Father", b"Matt Furie created $BOG in 2004 and Oldest mascot than $PEPE $HOPPY $FEFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ro_Wm_U3e_Zpt_ZSB_3_Wm_R_Zhhovk_Eu_Fha8_Pq_Ac_VUG_5_W4wuxs_H_6e5979ea86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

