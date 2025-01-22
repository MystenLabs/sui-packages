module 0x5837ee96e0cd550b00017594be11424898f4d6afac821777972b967bd396fdb1::desci {
    struct DESCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESCI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DESCI>(arg0, 6, b"DESCI", b"SUI Desci Agents by SuiAI", b"Launch DeSci assets, grow their audience with AI agents, and generate liquidity with mechanics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/f_Qd_XP_Gm_400x400_3150f333ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DESCI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESCI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

