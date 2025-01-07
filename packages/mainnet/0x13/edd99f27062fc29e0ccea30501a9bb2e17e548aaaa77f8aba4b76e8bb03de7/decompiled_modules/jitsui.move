module 0x13edd99f27062fc29e0ccea30501a9bb2e17e548aaaa77f8aba4b76e8bb03de7::jitsui {
    struct JITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JITSUI>(arg0, 6, b"JITSUI", b"Jitsu", b"SHARK OF THE MATSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EEE_2_DF_72_AD_3_E_4_D8_A_858_C_2_CC_62_EE_7_F229_54db4b92c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

