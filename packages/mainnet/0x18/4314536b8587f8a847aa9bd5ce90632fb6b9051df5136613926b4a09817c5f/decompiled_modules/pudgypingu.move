module 0x184314536b8587f8a847aa9bd5ce90632fb6b9051df5136613926b4a09817c5f::pudgypingu {
    struct PUDGYPINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGYPINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGYPINGU>(arg0, 6, b"PudgyPingu", b"Pudgy Pingu", x"4e4f4f54204e4f4f54212050696e6775206e6f772050756467696572207468616e20657665722064756520746f207468652068656c70206f662068697320636f6d6d756e697479212121204261636b65642062792054656c656772616d202620446973636f72642e2054616b6520666c69676874207769746820757320746f20676f206265796f6e64207468616e2068697320707564677920726976616c732e20557020746f20646174652073747265616d207769746820757320616e642068656c70206f75722050696e67752074616b6520666c696768742121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbfi_Fo_XU_5fjcmo_H_Ua_Nczh_Hq_JD_Tisyg2_Bh_SE_7c_G_Zika_Le_Q_0458a797b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGYPINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGYPINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

