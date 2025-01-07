module 0xd2ca374f5a461becebf98e75fe32145cf84c2113f2fbc890d1f8b19c31c11855::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 6, b"BRO", b"BROCODE", b"BRO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NQK_Mb_P4_Uu_Yn_Jpuf_TG_3_Be_V_Maaf_Hws_ZU_6u_Bp_T_Unpb7k665_bdfdab56f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

