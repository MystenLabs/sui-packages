module 0x760b578e0d91ad102a66ddf261266a988453afe7cbed10b4cb4e325cffcc79c4::sgoo {
    struct SGOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOO>(arg0, 6, b"SGOO", b"Slow Goo", b"a snail goes slow but pump fast!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Hre_Yu_Cmp_Xu_Qu5o_TKFQMMMRTC_5xag29u_Vdr_Mzn_Y_Mjcq1_cea0138aac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

