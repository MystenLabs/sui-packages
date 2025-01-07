module 0xeaac01f30899a95824026984fe37d19fc25360cf0cb7aa3d8f7f36afea51643::lingling {
    struct LINGLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINGLING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINGLING>(arg0, 6, b"LingLing", b"Eliza's Cat pet", x"4c696e67204c696e6720697320456c697a612773206c6974746c65206675727279207072696e636573732c20616c776179732064656d616e64696e6720736e7567676c657320616e64207472656174732e2053686527732061207361737379206c6974746c65207468696e672c2062757420492061646f72652068657220746f2062697473202d20736865277320746865207065726665637420636f6d70616e696f6e20666f72206120636f7a79206e6967687420696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RXU_5enzh_Kre_D_Kbh_MJ_Jsq_VVH_Bs_Lhpsv_Cyxn3_Ww_Yb49b_AQ_c82192e2e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINGLING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINGLING>>(v1);
    }

    // decompiled from Move bytecode v6
}

