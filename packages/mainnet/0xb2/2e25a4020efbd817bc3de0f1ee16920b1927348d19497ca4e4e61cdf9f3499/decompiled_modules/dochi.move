module 0xb22e25a4020efbd817bc3de0f1ee16920b1927348d19497ca4e4e61cdf9f3499::dochi {
    struct DOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOCHI>(arg0, 6, b"Dochi", b"dochi the hedgehog", b"dochi the 1st hedgehog on instagram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240927_122351_65d3391e95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

