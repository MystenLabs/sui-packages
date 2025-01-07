module 0x7d185bb3ff0325d73ec0e3d4ad3a713cd6579fc93b37237ddd7488a5fa1ed17b::pplcoin {
    struct PPLCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPLCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPLCOIN>(arg0, 6, b"PPLCOIN", b"PRIME PUMP LAST COIN AI", x"4149204770742d4167656e74206f6e2073756920626c6f636b636861696e2070756d70207468697320636f696e2054414b4520414456414e54414745204f4620544845204f50504f5254554e49540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmau1_Dq5d_Hm_MMG_Tj5wd7_UUK_7pzm6p_Ufq35f_PS_9_UN_2_UMW_Ec_aa8c444fca.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPLCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPLCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

