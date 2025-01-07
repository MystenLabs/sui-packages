module 0xc5dbf0a5b9c12757e592b68fe90ba419ad445376f0b89a487a3a4e710500cd2f::foldi {
    struct FOLDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOLDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOLDI>(arg0, 6, b"FOLDI", b"CATFOLDI", b"Fascinating world of CAT$FOLDI Game Join us on exciting journey where gaming and blockchain unite. Get ready to experience a new level of entertainment and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_024106_241_removebg_preview_49143ddecc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOLDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOLDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

