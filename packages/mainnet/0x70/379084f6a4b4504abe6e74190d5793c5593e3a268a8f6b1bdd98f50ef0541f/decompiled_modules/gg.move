module 0x70379084f6a4b4504abe6e74190d5793c5593e3a268a8f6b1bdd98f50ef0541f::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"gg", x"4d697373696f6e206163636f6d706c6973686564210a546865206f6666696369616c2024424853205768697465706170657220697320736563757265616e6420726561647920746f2064726f70206e6f773a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250430_162554_c88bc54680.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

