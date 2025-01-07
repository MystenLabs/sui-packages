module 0xd30a0f24ae557a1d927f8a25f03a526311dd362ecfcb246b9d468d2efec7c582::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"Anon Pepe", x"24414e4f4e203a20412073796d626f6c206f6620726573696c69656e63652c20696e74656c6c6967656e63652c20616e6420756e7969656c64696e6720636f6d6d69746d656e7420746f2066696e616e6369616c20736f7665726569676e74792c20636c6f616b656420696e20616e6f6e796d6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Fx_Vm_YY_8umskfr_Rr_E_Cqjs_Xhycq_WQ_Aa_K43_P3s_QC_Bwqm_Hb_1de89b47cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANON>>(v1);
    }

    // decompiled from Move bytecode v6
}

