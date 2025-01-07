module 0xd10bd684e13c6412badc427b50605783bae9c5c273a9945fab30b97a9a8aad19::aaacat {
    struct AAACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACAT>(arg0, 6, b"AAACAT", b"AAA Cat", b"First AAA CAT on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7005_ecdc82c8ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

