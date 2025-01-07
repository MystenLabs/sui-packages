module 0xf43f788b2eebc210ff1ae384dd85017cb63d626af12ebf36eac4df9a4cc9928f::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 6, b"WINTER", b"SUI WINTER", b"$WINTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd9_Kwhq_Ldo_Se_Qh_Ur_Qc4_JJ_Cc_V7te_Ka_N9o_H3_Lv9h94_Xqr_BV_178644438b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

