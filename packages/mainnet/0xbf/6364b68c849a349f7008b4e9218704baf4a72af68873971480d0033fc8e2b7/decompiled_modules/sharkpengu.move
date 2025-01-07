module 0xbf6364b68c849a349f7008b4e9218704baf4a72af68873971480d0033fc8e2b7::sharkpengu {
    struct SHARKPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKPENGU>(arg0, 6, b"SharkPengu", b"Shark Pengu", x"537072656164696e6720756e6465727761746572207669626573206163726f737320746865206d657461200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xe_Zvj_TR_Gi1cg_WB_Fcp_Ww_GGA_Cni_Fk_Hnxw_H_Ug134_P_Nwg4rr_ac45c0784b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

