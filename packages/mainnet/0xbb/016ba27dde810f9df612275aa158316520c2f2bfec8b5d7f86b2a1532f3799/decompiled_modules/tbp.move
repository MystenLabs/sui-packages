module 0xbb016ba27dde810f9df612275aa158316520c2f2bfec8b5d7f86b2a1532f3799::tbp {
    struct TBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBP>(arg0, 6, b"TBP", b"The Blue Pyramid", b"Open your minds to the possibility of an AI Sui future ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/the_pyramid_bc232af86f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBP>>(v1);
    }

    // decompiled from Move bytecode v6
}

