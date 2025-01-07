module 0xcf04fa9ff67cddf07717dbc870fa2e0e52c2f7abd5549a687b1d0948888ed00b::smo {
    struct SMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMO>(arg0, 6, b"SMO", b"SuiMO", x"5375694d6f2063616d65206865726520746f206d616b65206e6f6973652c20726174746c6520616e64206d616b65207761766573210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb5z_B_Nn_Wx_F_Rw7_Y133f_Z4_YS_Mi_EB_56kwtfxs_Ys_TA_8zcfk_F3_common_6cf40ba871.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

