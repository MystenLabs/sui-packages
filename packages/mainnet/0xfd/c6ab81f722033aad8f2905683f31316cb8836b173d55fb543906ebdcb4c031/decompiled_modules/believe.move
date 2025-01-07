module 0xfdc6ab81f722033aad8f2905683f31316cb8836b173d55fb543906ebdcb4c031::believe {
    struct BELIEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELIEVE>(arg0, 6, b"BELIEVE", b"believe", x"49742074616b657320612062656c696576657220746f207365652074686520677265656e657220736964652e204a757374202462656c6965766520616e64206275792074686520726564732e204d414b45205448454d202462656c69657665210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rcvm_Nv_Gutpii_XY_18_CE_27q_Ki_CN_47_Z62a_Y_Nbzk_V39gb5_Zk_583e4f1699.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELIEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELIEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

