module 0x3a2ae19ebf77443d4ddcbf7ef73eda66ce9bcc52c50de32ce455b06bd34cb769::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"TRUMP", b"The MAGA (TRUMP) crypto token is primarily used as a means of supporting conservative causes and candidates aligned with the \"Make America Great Again\" (MAGA) movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/27872_42c7c94b24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

