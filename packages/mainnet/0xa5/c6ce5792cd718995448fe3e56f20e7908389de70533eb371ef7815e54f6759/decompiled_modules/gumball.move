module 0xa5c6ce5792cd718995448fe3e56f20e7908389de70533eb371ef7815e54f6759::gumball {
    struct GUMBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMBALL>(arg0, 6, b"Gumball", b"Gumball Waterson", x"47657420696e746f2074686520776f726c64206f662047756d62616c6c206f6e2074686520537569206e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gumball_Waterson_ee03f51085.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

