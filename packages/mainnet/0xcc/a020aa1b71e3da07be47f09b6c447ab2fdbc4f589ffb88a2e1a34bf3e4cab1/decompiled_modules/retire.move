module 0xcca020aa1b71e3da07be47f09b6c447ab2fdbc4f589ffb88a2e1a34bf3e4cab1::retire {
    struct RETIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETIRE>(arg0, 6, b"RETIRE", b"The Last Play", x"746865206c61737420706c6179206265666f7265207265746972652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YG_14_Rrj2_STV_4ww9j_K_Wier_D2_Q_Vnd_Sv_DLE_Fk_Eyuf_B_Ax_NC_2_c8eef7c30a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

