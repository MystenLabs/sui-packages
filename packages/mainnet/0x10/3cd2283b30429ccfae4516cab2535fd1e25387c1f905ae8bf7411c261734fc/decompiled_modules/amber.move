module 0x103cd2283b30429ccfae4516cab2535fd1e25387c1f905ae8bf7411c261734fc::amber {
    struct AMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBER>(arg0, 6, b"AMBER", b"AMBER MONKEY", b"Pointing orangutan $AMBER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3581_b5f819062b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

