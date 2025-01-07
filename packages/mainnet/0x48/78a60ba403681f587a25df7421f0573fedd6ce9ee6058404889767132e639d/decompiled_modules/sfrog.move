module 0x4878a60ba403681f587a25df7421f0573fedd6ce9ee6058404889767132e639d::sfrog {
    struct SFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROG>(arg0, 6, b"SFROG", b"Sad Frog", b"Hi Sad Frog! i'm here!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bg_f8f8f8_flat_750x_075_f_pad_750x1000_f8f8f8_u2_24d6c025b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

