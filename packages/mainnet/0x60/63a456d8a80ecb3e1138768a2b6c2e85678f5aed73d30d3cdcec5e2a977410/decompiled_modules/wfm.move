module 0x6063a456d8a80ecb3e1138768a2b6c2e85678f5aed73d30d3cdcec5e2a977410::wfm {
    struct WFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFM>(arg0, 6, b"WFM", b"WATER FUCKING MELON", x"5765726520736d617368696e67207468726f756768207468652062756c6c736869742e2054686973206973206f6e65206a75696379202457415445524655434b494e474d454c4f4e206973206865726520746f206675636b2073686974207570210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb48_R19_Ju_Y_Naf231x_V1_YXCF_9uh_Mu_VY_6_S3_M_Pzo_X_Ck5_Xgis_b74f55813f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

