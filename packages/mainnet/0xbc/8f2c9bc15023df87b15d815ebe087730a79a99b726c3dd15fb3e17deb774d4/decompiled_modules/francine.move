module 0xbc8f2c9bc15023df87b15d815ebe087730a79a99b726c3dd15fb3e17deb774d4::francine {
    struct FRANCINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANCINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANCINE>(arg0, 6, b"Francine", b"Francine Smith", b"I need a coin as wild as my life, and $Francine was born.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_By_M_Ewjo_Qpyo4jrcx8_UA_Ge24_XE_2px_G_By_X_Hu5hao_B4o4i_1e02facdc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANCINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANCINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

