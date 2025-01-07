module 0x46525908903ee5f8b21d7f74627a3a9879ac82bb0e61259b8abd353e0e16465c::lllama {
    struct LLLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLLAMA>(arg0, 6, b"LLLAMA", b"LLLAMASUI", b"Lama on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_IN_Sr_TB_8_400x400_f41e2c9c91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

