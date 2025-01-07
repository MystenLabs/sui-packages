module 0x3f39dbe53c98ce46a68e0267c7a22d711281ce212408a3305022d99cfd733f93::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Trump", x"5468697320697320776865726520746865206d6f6e65792069732e205374616e6420776974682075732e20576520617265202452455055424c4943414e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_R2_B16_Cw_DML_Ba_Gx_Nu8_At_SR_1_KZ_Xegco9aj_Dco_Yip_MMSB_7_be2833e394.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

