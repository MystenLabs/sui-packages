module 0x1566c6f9368389224763647ab365c204fb9d5e99d6a59e4171f94feeff2bc155::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"Suipenguin", x"54686520436f6f6c65737420576164646c65206f6e205375690a446f6e74206d69737320796f7572206368616e636520746f2062652070617274206f662074686520636f6f6c65737420636f6d6d756e697479206f6e2074686520537569204e6574776f726b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_I_Rx_DL_7_400x400_61322605cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

