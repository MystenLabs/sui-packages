module 0x97dff2951da7df091c9a3dda371b65546b428d32ce77a87d8e9595a37f12a760::tree {
    struct TREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREE>(arg0, 6, b"TREE", b"Christmas Tree", b"$TREE is the ultimate Christmas meme coin, spreading holiday cheer on Sui! With fast transactions and limited availability, its your chance to light up your wallet with festive rewards. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qtidq_Vc_K2_Da_E7_B6_Zj_U_Hk2_Ao_Ns_Ut_FZ_Ayo_Z4_WWHMD_6r3_WL_8c03b32c99.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

