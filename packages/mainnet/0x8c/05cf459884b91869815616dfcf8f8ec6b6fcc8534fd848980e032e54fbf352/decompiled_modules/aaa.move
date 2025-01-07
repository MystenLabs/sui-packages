module 0x8c05cf459884b91869815616dfcf8f8ec6b6fcc8534fd848980e032e54fbf352::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"AAA CAT", b"I can't stop thinking about Sui!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAA_cc9c21d337.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

