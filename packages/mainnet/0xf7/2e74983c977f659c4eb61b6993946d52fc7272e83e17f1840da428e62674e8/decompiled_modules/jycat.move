module 0xf72e74983c977f659c4eb61b6993946d52fc7272e83e17f1840da428e62674e8::jycat {
    struct JYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JYCAT>(arg0, 6, b"JYCAT", b"Just A Yellow Cat", b"Just a yellow Cat on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sp7_52c74dbfe8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

