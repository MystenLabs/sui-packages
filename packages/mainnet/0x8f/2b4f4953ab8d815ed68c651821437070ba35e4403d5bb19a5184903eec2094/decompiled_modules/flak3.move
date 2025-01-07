module 0x8f2b4f4953ab8d815ed68c651821437070ba35e4403d5bb19a5184903eec2094::flak3 {
    struct FLAK3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAK3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAK3>(arg0, 6, b"FLAK3", b"FLAK 3", x"464c414b332028464c414b33290a41492c20776865726520696e74656c6c6967656e636520656d65726765732066726f6d207468652064796e616d696320696e746572706c6179206f66204372797374616c206d6f64756c65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_F_Lqwh_Epw_Hqiff_Pr_Dp_D_Hm4_Y9x1spr_W_Hs_Kk_Q_Gyu_J1hn_Ka_3c8ca1f419.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAK3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAK3>>(v1);
    }

    // decompiled from Move bytecode v6
}

