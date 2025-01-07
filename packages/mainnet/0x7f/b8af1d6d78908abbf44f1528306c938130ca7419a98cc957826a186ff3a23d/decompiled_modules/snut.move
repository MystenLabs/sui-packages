module 0x7fb8af1d6d78908abbf44f1528306c938130ca7419a98cc957826a186ff3a23d::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 6, b"SNUT", b"SNUT ON SUI", x"6a757374207468696e6b696e6720696e2073696d706c79206e65742c20697420697320776861742061206361746368696e6720766962652e2024534e55540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rm_Ukk8_WJF_Sk_Zr_Zf_Yt_Z36_A5_Zm2z_F_Nk_Bfx_Y59_KX_4y_Ae_Yw1_fd45e31c12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

