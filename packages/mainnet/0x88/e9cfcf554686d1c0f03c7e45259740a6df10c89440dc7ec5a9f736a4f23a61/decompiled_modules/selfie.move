module 0x88e9cfcf554686d1c0f03c7e45259740a6df10c89440dc7ec5a9f736a4f23a61::selfie {
    struct SELFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFIE>(arg0, 6, b"Selfie", b"selfie fish", b"Say Cheese", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Yhw_C_Xo_A_Ab2_Q4_1acc5e1ee2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

