module 0xe3dd17b9ecdf2bb9ada641e0fdd7c93b501d0a8cb6e1b4d5445e56c8512761c1::chloe {
    struct CHLOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLOE>(arg0, 6, b"CHLOE", b"Chloe the Coelacanth", b"The no.1 Fish on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/chloe_287c11104f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHLOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

