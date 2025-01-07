module 0x745f890bcea6551234a968c012e4264b99ad40990b36cf563c850f6880271af5::popwhale {
    struct POPWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPWHALE>(arg0, 6, b"POPWHALE", b"PopWhale", b"Whales pop in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sk_U6_UR_Xuz_A_Hp_Yyyjk19_Ac141_BC_3vx_Sdb_Yr9_W_Ze_E_Yx_HCY_29e43f140c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

