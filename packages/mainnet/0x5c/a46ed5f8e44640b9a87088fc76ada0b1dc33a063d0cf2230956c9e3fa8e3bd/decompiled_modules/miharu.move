module 0x5ca46ed5f8e44640b9a87088fc76ada0b1dc33a063d0cf2230956c9e3fa8e3bd::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 6, b"Miharu", b"smiling dolphin", x"536d696c696e67204d6968617275206973206120636f6d6d756e6974792d64726976656e2070726f6a6563742064656469636174656420746f20737072656164696e6720706f73697469766974792e2054686520746f6b656e20697320496e737069726564206279206120766972616c2070686f746f206f66204d69686172752c20612064656c6967687466756c206d616c652046696e6c65737320506f72706f6973652066726f6d204a6170616e2773204d6979616a696d6120417175617269756d2e204b65657020736d696c696e67210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6t_VZ_Vjcpp_H2_BZ_9_Xj5y_FU_1_Zt34m2r_Ycy_Dqqp_Se_MD_Zpump_b4d30e5812.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

