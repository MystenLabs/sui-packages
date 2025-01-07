module 0x87eca4dbea8b38ae3a8bcd13dc3a5b711d88c1b68743323bf08690cefb0effb::chillcoin {
    struct CHILLCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLCOIN>(arg0, 6, b"CHILLCOIN", b"Chillcoin", x"4368696c6c636f696e20284368696c6c636f696e290a54616b652061206368696c6c2070696c6c20616e64206a6f696e20746865206d6f7374206368696c6c20636f6d6d756e697479206f6e20536f6c616e612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb1_Qf28p4sun2r2c_V4m_W_Txnfbof_A_Hz_FP_7g_JRH_Mqmc_S_Frq_490e79891f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

