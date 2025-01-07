module 0x88a25de9fb954406e41bbca0d72179019746ed0e1614103e61277aa74579b494::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"this dog only goes up", b"go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme38y5_Vs_BX_Vez3_Eys_Aw_Pbb47hm_V_En88_L_Haw3_W9u6_D6q_LN_16508fc900.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

