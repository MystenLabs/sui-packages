module 0x2ecfb35d6769692565314dafdb7af53680c61cf4b258d29cc148e85d11880012::bkts {
    struct BKTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKTS>(arg0, 6, b"BKTS", b"BabyKrypto", x"426162794b727970746f20656d657267657320617320612064796e616d6963206d656d636f696e20706f6973656420746f207265646566696e65207468652063727970746f63757272656e637920657870657269656e63652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zfgp_W_Wost7i_WC_Qkj15di7atqc36_Tqe3t4g_Ba5_N1r4y8e_c6b67a41d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

