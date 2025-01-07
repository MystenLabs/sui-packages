module 0x2800515d44cc176d93cf0c9fd9649a7b3227d93baeb82c126c77ab025ab1c960::tube {
    struct TUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUBE>(arg0, 6, b"TUBE", b"SuiTube", b"Empowering creators with blockchain technology. Stream, share, and earn in a truly open ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/58_C6_B3_A2_D57_F_4562_A7_BE_C20_BAB_51_FF_89_d4969a6586.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

