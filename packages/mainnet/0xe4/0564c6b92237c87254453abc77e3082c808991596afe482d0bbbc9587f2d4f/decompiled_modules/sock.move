module 0xe40564c6b92237c87254453abc77e3082c808991596afe482d0bbbc9587f2d4f::sock {
    struct SOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCK>(arg0, 6, b"SOCK", b"SUISOCK", b"Just $SOCK on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisock_logo_e75f333324.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

