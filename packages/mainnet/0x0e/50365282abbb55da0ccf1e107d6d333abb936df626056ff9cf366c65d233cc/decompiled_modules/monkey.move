module 0xe50365282abbb55da0ccf1e107d6d333abb936df626056ff9cf366c65d233cc::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"BAG OF MONKEYS", b"A bag full of happy monkeys.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qq_S5_C_Mg6jz_U66ufqvcw_Nv_RMZ_Ss1h7b6cu_R1_L_Pu_E6_Rg_XB_ec27c93e31.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

