module 0x1c5a5048f0d45a94b8f4f989cfdf063a6a6f39d8247e35011f84e14c17f2f735::pumpkin {
    struct PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIN>(arg0, 6, b"Pumpkin", b"Halloween AI PumpDev", x"4920776f756c64206c696b6520746f2062652063616c6c65642050756d706465760a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb41_Ec_Ysro_A72t_Ftgf_DPX_Ej_JM_Do3_Q_Kd_Gwgg_BAHR_Ln_JB_Fb_4484f05c88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

