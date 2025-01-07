module 0xf25a7bbb1dc62fb8e708fb2a4332fe982ff9afe014ba0aa4cd71eb292e7f9e3c::manny {
    struct MANNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANNY>(arg0, 6, b"MANNY", b"MANFRED THE MAMMOTH", b"A Bullephant that teleports from The Ice Age to The Sui Age.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/manny_12b93aae90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

