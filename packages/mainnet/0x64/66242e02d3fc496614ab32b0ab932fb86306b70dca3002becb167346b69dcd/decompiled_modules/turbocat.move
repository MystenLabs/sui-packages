module 0x6466242e02d3fc496614ab32b0ab932fb86306b70dca3002becb167346b69dcd::turbocat {
    struct TURBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOCAT>(arg0, 6, b"TURBOCAT", b"TURBO CAT", b"Hi, I'm Turbo, the coolest cat on sui! Yes, I'm like that - I jump like a real athlete, or almost... But every jump I make is a show! Also, between you and me, I love to eat fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001211519.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

