module 0x29a83c793dab022a4fdfd70df95bcae475cce8a9384742741c033f17f5e6438::jumbo {
    struct JUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMBO>(arg0, 6, b"JUMBO", b"Jumbo on sui", x"4f6e636520612073796d626f6c206f662061206461726b20706572696f6420696e2050756d7046756e277320686973746f72792c2074686973206368756262792c204a554d424f2063617420666f756e6420736f6c61636520616e64207472616e73666f726d6174696f6e207468726f756768206120706561636566756c2063616d706169676e206e616d656420244a554d424f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_PBJ_Lqcx_Kxfc_T8ee4b_JU_Pxr_C1_Nw_Wz2roii4c_GBNP_Qc_Lv_a5efcd7af5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

