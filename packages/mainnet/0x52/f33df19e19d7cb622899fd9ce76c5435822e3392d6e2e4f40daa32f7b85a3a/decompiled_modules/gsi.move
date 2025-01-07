module 0x52f33df19e19d7cb622899fd9ce76c5435822e3392d6e2e4f40daa32f7b85a3a::gsi {
    struct GSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSI>(arg0, 6, b"GSI", b"Ghost SUI", x"47686f73742077696c6c2062652047686f7374200a6e657665722066696e64206974202121200a436f6d65206f722064696520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a6_G4_Ww7hcl_88_I7_V_Of_QW_Oxj_SK_8_I5_H_Yeavm_Om_Tmbb_Ju_Q_49f75b3d42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

