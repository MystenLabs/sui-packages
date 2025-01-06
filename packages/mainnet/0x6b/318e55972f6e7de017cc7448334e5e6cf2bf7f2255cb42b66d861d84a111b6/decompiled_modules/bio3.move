module 0x6b318e55972f6e7de017cc7448334e5e6cf2bf7f2255cb42b66d861d84a111b6::bio3 {
    struct BIO3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIO3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIO3>(arg0, 6, b"Bio3", b"Biosphere3", x"436974697a656e20536369656e63652047616d6520207c204d756c74692d6167656e7420436976696c697a6174696f6e2045766f6c7574696f6e204578706572696d656e7420207c204275696c64696e6720536f7665726569676e7479204167656e74732026204469676974616c204c696665666f726d202068747470733a2f2f782e636f6d2f62696f737068657265335f61690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Xv21_Mes_Lr_Hzc8_S_Gk_M6i_A_Jei_JF_Mq_A3u_C_Mg_Biybjpxx_QA_23f799538f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIO3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIO3>>(v1);
    }

    // decompiled from Move bytecode v6
}

