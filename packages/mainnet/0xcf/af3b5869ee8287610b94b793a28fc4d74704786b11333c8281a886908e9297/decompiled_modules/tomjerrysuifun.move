module 0xcfaf3b5869ee8287610b94b793a28fc4d74704786b11333c8281a886908e9297::tomjerrysuifun {
    struct TOMJERRYSUIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMJERRYSUIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMJERRYSUIFUN>(arg0, 6, b"Tomjerrysuifun", b"Tomjerrysui", b"Fun coming ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000907774_b1a04a01d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMJERRYSUIFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMJERRYSUIFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

