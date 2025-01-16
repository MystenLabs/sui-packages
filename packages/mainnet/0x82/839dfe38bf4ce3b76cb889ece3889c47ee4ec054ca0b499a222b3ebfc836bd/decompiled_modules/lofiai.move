module 0x82839dfe38bf4ce3b76cb889ece3889c47ee4ec054ca0b499a222b3ebfc836bd::lofiai {
    struct LOFIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFIAI>(arg0, 6, b"LOFIAI", b"LOFI AI", b"THE OFFICIAL LOFI AI LAUNCH ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lofi_ai_fa0b62579c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

