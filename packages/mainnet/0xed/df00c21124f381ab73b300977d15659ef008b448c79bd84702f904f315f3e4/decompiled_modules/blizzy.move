module 0xeddf00c21124f381ab73b300977d15659ef008b448c79bd84702f904f315f3e4::blizzy {
    struct BLIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLIZZY>(arg0, 6, b"BLIZZY", b"The Sui Yeti Blizzy", x"4d6565742024424c495a5a592e20546865205375692079657469207769746820426c696e672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Gf_Sj_ZHM_3_N_Av6_Q_Xxfru_P4o_T_Zip_Yv6_GH_Qo_Hg_BXJ_Vvpump_872b82fcd5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

