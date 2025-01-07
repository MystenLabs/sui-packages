module 0xb21785c92c8db5f5096c6f89122defb6b7fe03c6662f31eb4e9c01638aee957a::bebop {
    struct BEBOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBOP>(arg0, 6, b"BEBOP", b"BEBOP SUI", b"$BEBOP - See you on SUI, Space Cowboy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_S_Nstb_EYV_En2i_TN_Qy_ZHK_Gzg_TP_Zw_Bgnujw_Ka8hn5opump_69041aafa2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

