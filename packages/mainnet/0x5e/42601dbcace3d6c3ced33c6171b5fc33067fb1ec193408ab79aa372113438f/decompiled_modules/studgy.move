module 0x5e42601dbcace3d6c3ced33c6171b5fc33067fb1ec193408ab79aa372113438f::studgy {
    struct STUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUDGY>(arg0, 6, b"Studgy", b"Studgy the Penguin", x"4d656574205374756467792c20507564677950656e6775696e73206a61636b65642062726f74686572212048652072756c6573207468652067796d20616e6420726f756c657474652c2070726f76696e6720737563636573732069732061626f757420686967686572207374616e64617264732c206e6f74206a75737420636f696e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_HK_Zubn9mz6f_H3_Tr_Wm_W_Ry_Hq_Qkwga_Lcnx_Skev_Yf_Zj1223_8fcfee7919.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUDGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUDGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

