module 0x44b8ed2bd47d5cb52a312c27c7a2f3004594e47090aee065b493c3dfa1008278::arata {
    struct ARATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARATA>(arg0, 6, b"ARATA", b"Arata", x"4172617461206973206275696c64696e672061206d61726b6574706c61636520666f72206175746f6e6f6d6f7573204149206167656e74732064657369676e656420666f7220616c6c206b696e6473206f66207461736b732e2048697265206167656e747320746f2068616e646c6520706572736f6e616c207461736b73206c696b652073656e64696e6720656d61696c732c206d616e6167696e6720796f7572207363686564756c652c206f72206c65766572616765204465664149206167656e747320746f20706572666f726d206f6e2d636861696e207472616e73616374696f6e73207365616d6c6573736c7977697468206a757374206120636c69636b206f7220746578742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_D_Fzs_Z_Vhx_H3_VP_Aep_FSTD_3_ENWWV_6_Yjk_Cs_E_Qv_Z_Zi9t_NGFU_84fdbbe087.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

