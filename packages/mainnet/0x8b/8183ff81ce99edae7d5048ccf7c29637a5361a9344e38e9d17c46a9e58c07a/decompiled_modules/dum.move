module 0x8b8183ff81ce99edae7d5048ccf7c29637a5361a9344e38e9d17c46a9e58c07a::dum {
    struct DUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUM>(arg0, 6, b"DUM", b"DUM SUI", b"\"All degens are clueless, and $DUM perfectly embodies the essence of a degenfunny, playful, and a bit of a loser, yet unapologetic about it. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4du_Tszd_Ut_J2w_E7_E_Hs_MMJ_4_Pmd_Yz_Y4fi_S85uh_L4i_Rrpump_4a5c67d822.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

