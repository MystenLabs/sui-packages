module 0xe5dfa15df017cf77d0809fa70d741a4a9661bb4adf35aacd12c83df3e789c856::kyle {
    struct KYLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYLE>(arg0, 6, b"KYLE", b"Kyle", x"0a4b594c4520697320616e2061646f7261626c652079657420736176767920646f672c206b6e6f776e20666f72206265696e672074686520756c74696d61746520636f6d70616e696f6e20746f20646567656e732e20576974682061206b65656e2073656e736520666f7220736e696666696e67206f75742070726f666974732c204b594c4520697320616c7761797320627920796f757220736964652c206c656164696e672074686520776179207468726f756768207468652077696c6420776f726c64206f662063727970746f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcj_X7_U2zt_Ga_Vibyf9ffk_Kfqe_E2ue5g_Px_D7_VHWRFE_Lkhi_Q_79ee39fc11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KYLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

